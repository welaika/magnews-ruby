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


    it "returns a list of contacts" do
      stub_request(:get, "#{Magnews.endpoint}/#{Magnews.api_version}/contacts/query?query=SELECT%20*%20FROM%20CONTACTS%20WHERE%20iddatabase=1").to_return(body: '[{"iddatabase":2,"idcontact":1,"status":"subscribed","fields":{"causa_sospensione":"0","lingua":"","cognome":"Rossi","data_iscrizione":"30/06/2015 18:07","notrack":"","timezone":"","dominio":"example.com","data_ultima_azione":"","cell":"+33333333","data_sospensione":"","iddeliverycluster":"0","login":"mario.rossi@example.com","password":"1234","idlettore":"2","causa_eliminazione":"0","data_ultima_esportazione":"","fax":"","provenienza":"1","email":"mario.rossi@example.com","nome_utente":"mario.rossi@example.com","primarykey":"mario.rossi@example.com","riceve_fax":"No","riceve_sms":"SxC3xAC","suspend_til_date":"","idfriend":"0","nome":"Mario","check":"12323","riceve_email":"SxC3xAC","data_conf_isc":"","idcliente":"1792","formato_spedizione":"2","data_ultima_modifica":"30/06/2015 18:07","idaddressbook":"2","flag_stato":"0","data_eliminazione":""}}]')
      expect(described_class.list_all).to eq({'mario.rossi@example.com' => 1})
    end

    it "returns an empty list of contacts" do
      stub_request(:get, "#{Magnews.endpoint}/#{Magnews.api_version}/contacts/query?query=SELECT%20*%20FROM%20CONTACTS%20WHERE%20iddatabase=1").to_return(body: '[]')
      expect(described_class.list_all).to eq({})
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
