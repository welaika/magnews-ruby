require "rest-client"
require "active_support"
require "active_support/core_ext"

require "magnews/version"
require "magnews/errors"
require "magnews/util/configuration"
require "magnews/util/header_helper"
require "magnews/util/url_helper"

module Magnews
  extend SingleForwardable

  def_delegators :configuration, :auth_token, :logger

  def self.configure(&block)
    yield configuration
  end

  def self.configuration
    @configuration ||= Util::Configuration.new
  end
  private_class_method :configuration
end
