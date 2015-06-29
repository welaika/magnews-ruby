require "spec_helper"

describe Magnews do
  after(:each) do
    Magnews.instance_variable_set("@configuration", nil)
  end

  it "has a version number" do
    expect(Magnews::VERSION).not_to be nil
  end

  Magnews::Util::Configuration::DEFAULTS.each_key do |configuration|
    it { should delegate_method(configuration).to(:configuration) }
  end

 end
