module Magnews
  module Util
    class Configuration
      attr_accessor :auth_token
      attr_reader :logger

      def logger=(logger)
        @logger = logger
        RestClient.log = @logger
      end
    end
  end
end
