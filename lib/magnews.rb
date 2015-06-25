require "rest-client"
require "active_support"
require "active_support/core_ext"

require "magnews/version"
require "magnews/util/configuration"

module Magnews
  extend SingleForwardable

  def_delegators :configuration, :auth_token

  def self.configure(&block)
    yield configuration
  end

  def self.configuration
    @configuration ||= Util::Configuration.new
  end
  private_class_method :configuration
end
