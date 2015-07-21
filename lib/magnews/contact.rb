module Magnews
  class Contact < OpenStruct
    extend Magnews::HeaderHelper
    extend Magnews::UrlHelper
    extend Magnews::LoggerHelper

    class << self
      def create!(values, options={})
        normalize_values!(values)
        payload = { options: options.reverse_merge({ iddatabase: Magnews.iddatabase }), values: values }.to_json
        RestClient.post(url_for("contacts/subscribe"), payload, common_headers) do |response, request, result, &block|
          logger.info { response.body }

          if (200..207).include? response.code
            respond_to_200(response)
          elsif Magnews::EXCEPTIONS_MAP[response.code].present?
            raise Magnews::EXCEPTIONS_MAP[response.code].new(response, response.code)
          else
            response.return!(request, result, &block)
          end
        end
      end

      def delete!(email, options={})
        payload = { options: options.reverse_merge({ iddatabase: Magnews.iddatabase }), values: { email: email } }.to_json
        RestClient.post(url_for("contacts/unsubscribe"), payload, common_headers) do |response, request, result, &block|
          logger.info { response.body }
          if (200..207).include? response.code
            respond_to_200(response)
          elsif Magnews::EXCEPTIONS_MAP[response.code].present?
            raise Magnews::EXCEPTIONS_MAP[response.code].new(response, response.code)
          else
            response.return!(request, result, &block)
          end
        end
      end

      def list_all
        response = query_users
        return {} if response.empty?
        response.reject! { |r| r[:status] != "subscribed" }
        response.each_with_object({}) { |r, obj| obj[r[:fields][:email]] = r[:idcontact] }
      end

      def list_unsubscribed
        response = query_users
        return {} if response.empty?
        response.reject! { |r| r[:status] != "unsubscribed" }
        response.each_with_object({}) { |r, obj| obj[r[:fields][:email]] = r[:idcontact] }
      end

      def respond_to_200(response)
        body = JSON.parse(response.body).deep_symbolize_keys!
        if body[:ok]
          return true
        else
          response.code = 422
          raise  Magnews::EXCEPTIONS_MAP[response.code].new(response, response.code)
        end
      end

      def normalize_values!(values)
        values.each do |key, value|
          values[key] = value.join(",") if value.is_a? Array
        end
      end

      private

      def query_users
        query = "SELECT * FROM CONTACTS WHERE iddatabase=#{Magnews.iddatabase}"
        response = RestClient.get(URI.escape(url_for("contacts/query?query=#{query}")), auth_header)
        response = JSON.parse response
        response.each(&:deep_symbolize_keys!)
      end
    end
  end
end

