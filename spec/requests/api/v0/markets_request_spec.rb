require 'rails_helper'

describe "Markets API" do

  # User Story 1
  it "sends back all markets" do
    create_list(:market, 10)

    get '/api/v0/markets'
    parsed_json = JSON.parse(response.body, symbolize_names: true)
    markets = parsed_json[:data]

    expect(parsed_json[:data]).to be_a (Array)
    expect(parsed_json[:data][0]).to be_a (Hash)
    expect(markets.count).to eq(10)

    expect(response.code).to eq("200")
    expect(response).to be_successful

    markets.each do |market|
      expect(market).to have_key(:id)
      expect(market[:attributes]).to have_key(:name)
      expect(market[:attributes]).to have_key(:street)
      expect(market[:attributes]).to have_key(:city)
      expect(market[:attributes]).to have_key(:county)
      expect(market[:attributes]).to have_key(:state)
      expect(market[:attributes]).to have_key(:zip)
      expect(market[:attributes]).to have_key(:lat)
      expect(market[:attributes]).to have_key(:lon)
      expect(market[:attributes]).to have_key(:vendor_count)
      expect(market[:id]).to be_a (String)     
      expect(market[:attributes][:name]).to be_a(String)
      expect(market[:attributes][:street]).to be_a(String)
      expect(market[:attributes][:city]).to be_a(String)
      expect(market[:attributes][:county]).to be_a(String)
      expect(market[:attributes][:state]).to be_a(String)
      expect(market[:attributes][:zip]).to be_a(String)
      expect(market[:attributes][:lat]).to be_a(String)
      expect(market[:attributes][:lon]).to be_a(String)
      expect(market[:attributes][:vendor_count]).to be_a(Integer)
    end
  end
end