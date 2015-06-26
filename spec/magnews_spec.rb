require "spec_helper"

describe Magnews do
  after(:each) do
    Magnews.instance_variable_set("@configuration", nil)
  end

  it "has a version number" do
    expect(Magnews::VERSION).not_to be nil
  end

  context "with a config block" do
    let(:logger) { double("Logger") }

    it "should set the auth token" do
      described_class.configure do |config|
        config.auth_token = "someToken"
      end
      expect(described_class.auth_token).to eq("someToken")
    end

    it "should set a logger" do
      described_class.configure do |config|
        config.logger = logger
      end
      expect(described_class.logger).to eq(logger)
    end
  end
end
