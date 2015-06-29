require "spec_helper"

describe Magnews::Util::Configuration do
  let(:logger) { double("logger") }

  described_class::DEFAULTS.each do |attribute, value|
    it "sets an #{attribute} with a default value" do
      config = described_class.new
      expect(config.send(attribute)).to eq(value)
    end

    it "can update the value for #{attribute}" do
      config = described_class.new
      config.send("#{attribute}=", "blah")
      expect(config.send(attribute)).to eq("blah")
    end

    it "can set the value for #{attribute} from a hash in the initializer" do
      config = described_class.new(attribute => "blah")
      expect(config.send(attribute)).to eq("blah")
    end
  end
end
