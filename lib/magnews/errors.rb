module Magnews

  EXCEPTIONS_MAP = {}

  class MissingAuthToken < StandardError; end

  RestClient::Exceptions::EXCEPTIONS_MAP.each_pair do |code, rc_klass|
    klass = Class.new(rc_klass)
    const_set rc_klass.name.demodulize, klass
    EXCEPTIONS_MAP[code] = klass
  end

  UnprocessableEntity.class_eval do

    def errors
      JSON.parse(http_body).deep_symbolize_keys[:errors]
    end
  end
end
