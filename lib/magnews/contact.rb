module Magnews
  class Contact < OpenStruct
    extend Magnews::HeaderHelper
    extend Magnews::UrlHelper

    class << self
      def create!(values, options={})
        values.transform_values! do |value|
          case value
          when Array
            value.join(",")
          else
            value
          end
        end
        payload = { options: options.reverse_merge({ iddatabase: Magnews.iddatabase }), values: values }.to_json
        RestClient.post(url_for("contacts/subscribe"), payload, common_headers) do |response, request, result, &block|
          if (200..207).include? response.code
            body = JSON.parse(response.body).deep_symbolize_keys!
            if body[:ok]
              return true
            else
              response.code = 422
              raise  Magnews::EXCEPTIONS_MAP[response.code].new(response, response.code)
            end
          elsif Magnews::EXCEPTIONS_MAP[response.code].present?
            raise Magnews::EXCEPTIONS_MAP[response.code].new(response, response.code)
          else
            response.return!(request, result, &block)
          end
        end
      end
    end
  end
end

