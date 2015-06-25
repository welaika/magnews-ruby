require "spec_helper"

describe Magnews::Util::Configuration do
  it "should have an auth token attribute" do
    config = Magnews::Util::Configuration.new
    config.auth_token = "someToken"
    expect(config.auth_token).to eq("someToken")
  end
end
