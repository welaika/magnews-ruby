module Magnews
  module Util
    class Configuration

      DEFAULTS = {
        api_version: "v19",
        endpoint: "https://ws-mn1.mag-news.it/ws/rest/api",
        iddatabase: 1,
        logger: Logger.new(STDOUT),
        auth_token: nil
      }

      DEFAULTS.each_key do |attribute|
        attr_accessor attribute
      end

      def initialize(opts={})
        DEFAULTS.each do |attribute, value|
          send("#{attribute}=".to_sym, opts.fetch(attribute, value))
        end
      end

      def logger=(logger)
        @logger = logger
        RestClient.log = @logger
      end

    end
  end
end
