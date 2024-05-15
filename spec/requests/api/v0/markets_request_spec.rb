require 'rails_helper'

describe "Markets API" do

  # User Story 1
  it "sends back all markets" do
    create_list(:market, 10)

    get "/api/v0/markets"
    parsed_json = JSON.parse(response.body, symbolize_names: true)
    markets = parsed_json[:data]

    expect(parsed_json[:data]).to be_a (Array)
    expect(parsed_json[:data][0]).to be_a (Hash)
    expect(markets.count).to eq(10)

    expect(response.code).to eq("200")
    expect(response).to be_successful

    markets.each do |market|
      expect(market).to have_key(:id)
      expect(market[:id]).to be_a(String)
      expect(market).to have_key(:type)
      expect(market[:type]).to be_a(String)
      expect(market).to have_key(:attributes)
      expect(market[:attributes]).to be_a(Hash)
      expect(market[:attributes]).to have_key(:name)
      expect(market[:attributes][:name]).to be_a(String)
      expect(market[:attributes]).to have_key(:street)
      expect(market[:attributes][:street]).to be_a(String)
      expect(market[:attributes]).to have_key(:city)
      expect(market[:attributes][:city]).to be_a(String)
      expect(market[:attributes]).to have_key(:county)
      expect(market[:attributes][:county]).to be_a(String)
      expect(market[:attributes]).to have_key(:state)
      expect(market[:attributes][:state]).to be_a(String)
      expect(market[:attributes]).to have_key(:zip)
      expect(market[:attributes][:zip]).to be_a(String)
      expect(market[:attributes]).to have_key(:lat)
      expect(market[:attributes][:lat]).to be_a(String)
      expect(market[:attributes]).to have_key(:lon)
      expect(market[:attributes][:lon]).to be_a(String)
      expect(market[:attributes]).to have_key(:vendor_count)
      expect(market[:attributes][:vendor_count]).to be_a(Integer)
    end
  end

  # User Story 2 - Happy Path
  it "sends back a single market (happy)" do
    market = create(:market)

    get "/api/v0/markets/#{market.id}"

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    market_data = parsed_json[:data]

    expect(response.code).to eq("200")
    expect(response).to be_successful

    expect(market_data).to have_key(:id)
    expect(market_data[:id]).to be_a(String)  
    expect(market_data).to have_key(:type)
    expect(market_data[:type]).to be_a(String)
    expect(market_data).to have_key(:attributes)
    expect(market_data[:attributes]).to be_a(Hash)
    expect(market_data[:attributes]).to have_key(:name)
    expect(market_data[:attributes][:name]).to be_a(String)
    expect(market_data[:attributes]).to have_key(:street)
    expect(market_data[:attributes][:street]).to be_a(String)
    expect(market_data[:attributes]).to have_key(:city)
    expect(market_data[:attributes][:city]).to be_a(String)
    expect(market_data[:attributes]).to have_key(:county)
    expect(market_data[:attributes][:county]).to be_a(String)
    expect(market_data[:attributes]).to have_key(:state)
    expect(market_data[:attributes][:state]).to be_a(String)
    expect(market_data[:attributes]).to have_key(:zip)
    expect(market_data[:attributes][:zip]).to be_a(String)
    expect(market_data[:attributes]).to have_key(:lat)
    expect(market_data[:attributes][:lat]).to be_a(String)
    expect(market_data[:attributes]).to have_key(:lon)
    expect(market_data[:attributes][:lon]).to be_a(String)
    expect(market_data[:attributes]).to have_key(:vendor_count)
    expect(market_data[:attributes][:vendor_count]).to be_a(Integer)
  end

  # User Story 2 - Sad Path
  it "sends back a single market (sad)" do
    get "/api/v0/markets/123123123123"

    expect(response.code).to eq("404")
    expect(response).not_to be_successful

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq("Couldn't find Market with 'id'=123123123123")
  end

  # User Story 3 - Happy Path
  it "sends back a a list of vendors that belong to a market" do
    market = create(:market)
    vendors = create_list(:vendor, 5)
    vendors.each do |vendor|
      MarketVendor.create!(market_id: market.id, vendor_id: vendor.id)
    end

    get "/api/v0/markets/#{market.id}/vendors"

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    market_vendor_data = parsed_json[:data]

    expect(response.code).to eq("200")
    expect(response).to be_successful

    market_vendor_data.each do |vendor|
      expect(vendor).to have_key(:id)
      expect(vendor[:id]).to be_a(String)
      expect(vendor).to have_key(:type)
      expect(vendor[:id]).to be_a(String)
      expect(vendor).to have_key(:attributes)
      expect(vendor[:attributes]).to be_a(Hash)
      expect(vendor[:attributes]).to have_key(:name)
      expect(vendor[:attributes][:name]).to be_a(String)
      expect(vendor[:attributes]).to have_key(:description)
      expect(vendor[:attributes][:description]).to be_a(String)
      expect(vendor[:attributes]).to have_key(:contact_name)
      expect(vendor[:attributes][:contact_name]).to be_a(String)
      expect(vendor[:attributes]).to have_key(:contact_phone)
      expect(vendor[:attributes][:contact_phone]).to be_a(String)
      expect(vendor[:attributes]).to have_key(:credit_accepted)
      expect(vendor[:attributes][:credit_accepted]).to be(true).or be(false)
    end
  end

  # User Story 3 - Sad Path
  it "sends back a a list of vendors that belong to a market (sad)" do
    get "/api/v0/markets/123123123123/vendors"

    expect(response.code).to eq("404")
    expect(response).not_to be_successful

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq("Couldn't find Market with 'id'=123123123123")
  end
end