require "spec_helper"

describe Magnews do
  after(:each) do
    Magnews.instance_variable_set("@configuration", nil)
  end

  it "has a version number" do
    expect(Magnews::VERSION).not_to be nil
  end

  it "should set the auth token with a config block" do
    Magnews.configure do |config|
      config.auth_token = "someToken"
    end
    expect(Magnews.auth_token).to eq("someToken")
  end
end
