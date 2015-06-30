require "rest-client"
require "active_support"
require "active_support/core_ext"
require "json"
require "logger"

require "magnews/version"
require "magnews/errors"
require "magnews/util/configuration"
require "magnews/util/header_helper"
require "magnews/util/url_helper"
require "magnews/util/logger_helper"
require "magnews/response"
require "magnews/contact"

module Magnews
  extend SingleForwardable

  def_delegators :configuration, *Util::Configuration::DEFAULTS.keys

  def self.configure(&block)
    yield configuration
  end

  def self.configuration
    @configuration ||= Util::Configuration.new
  end
  private_class_method :configuration
end
