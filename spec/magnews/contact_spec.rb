require "spec_helper"

describe Magnews::Contact do

  context ".create!" do
    let(:auth_token) { "someToken" }
    let(:values) do
      {
        nome: "Mario",
        cognome: "Rossi",
        email: "mario.rossi@example.com",
        negozio_preferito: "Cairo",
        interessi: ["Sport", "Fai da te"],
        insegna_planetsport: true,
        insegna_granbrico: false,
        insegna_grancasa: false
      }
    end
    let(:options) do
      {
        iddatabase: 2
      }
    end

    before do
      Magnews.configure do |config|
        config.auth_token = "someToken"
      end
    end

    it "creates a valid request to Magnews" do
      stub = stub_request(:post, "#{Magnews.endpoint}/#{Magnews.api_version}/contacts/subscribe").
        with(
          body: "{\"options\":{\"iddatabase\":2},\"values\":{\"nome\":\"Mario\",\"cognome\":\"Rossi\",\"email\":\"mario.rossi@example.com\",\"negozio_preferito\":\"Cairo\",\"interessi\":\"Sport,Fai da te\",\"insegna_planetsport\":true,\"insegna_granbrico\":false,\"insegna_grancasa\":false}}",
          headers: {'Accept'=>'application/json', 'Authorization'=>'Bearer someToken', 'Content-Type'=>'application/json'}
      ).and_return(status: 200, body: "{\"ok\":true}")
      described_class.create!(values, options)
      expect(stub).to have_been_requested
    end

    it "returns true if response 'ok' is 'true'" do
      stub_request(:post, "#{Magnews.endpoint}/#{Magnews.api_version}/contacts/subscribe").to_return(status: 200, body: "{\"ok\":true}")
      expect(described_class.create!(values, options)).to eq(true)
    end

    it "raises Unauthorized if token is wrong" do
      stub_request(:post, "#{Magnews.endpoint}/#{Magnews.api_version}/contacts/subscribe").to_return(status: 401)
      expect { described_class.create!(values, options) }.to raise_error(Magnews::Unauthorized)
    end

    it "raises UnprocessableEntity if validation errors occurred" do
      stub_request(:post, "#{Magnews.endpoint}/#{Magnews.api_version}/contacts/subscribe").to_return(status: 200, body: "{\"ok\":false,\"pk\":\"wrong email\",\"idcontact\":0,\"action\":\"insert\",\"errors\":[{\"type\":\"EMPTY_REQUIRED_FIELD\",\"field\":\"negozio_preferito\"},{\"type\":\"SYNTAX_ERROR\",\"field\":\"email\"}],\"sendemail\":null}")
      expect { described_class.create!(values, options) }.to raise_error do |error|
        expect(error).to be_a Magnews::UnprocessableEntity
        expect(error.errors).to match_array([{:type=>"EMPTY_REQUIRED_FIELD", :field=>"negozio_preferito"}, {:type=>"SYNTAX_ERROR", :field=>"email"}])
      end
    end

  end
end
