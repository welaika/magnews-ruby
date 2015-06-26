require "spec_helper"

describe Magnews::Util::Configuration do
  let(:logger) { double("logger") }

  it "should have an auth token attribute" do
    config = described_class.new
    config.auth_token = "someToken"
    expect(config.auth_token).to eq("someToken")
  end

  it "should have a logger attribute" do
    config = described_class.new
    config.logger = logger
    expect(config.logger).to eq(logger)
  end

  it "should set RestClient log" do
    config = described_class.new
    config.logger = logger
    expect(RestClient.log).to eq(logger)
  end
end
