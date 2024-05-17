require 'rails_helper'

describe "Market Nearest ATMs API" do
  it "sends a list of nearest atms to specific market (happy 200) - valid with data (multiple)" do
    market = create(:market, lat: 35.07904, lon: -106.60068)
    headers = {"CONTENT_TYPE" => "application/json"}

    get "/api/v0/markets/#{market.id}/nearest_atms"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    atm_data = parsed_json[:data]

    expect(atm_data).to be_a(Array)
    expect(atm_data.count).to eq(12)

    atm_data.each do |atm|    
      expect(atm).to be_a (Hash)
      expect(atm).to have_key(:id)
      expect(atm[:id]).to be(nil)  
      expect(atm).to have_key(:type)
      expect(atm[:type]).to be_a(String)
      expect(atm).to have_key(:attributes)
      expect(atm[:attributes]).to be_a(Hash)

      expect(atm[:attributes]).to have_key(:name)
      expect(atm[:attributes][:name]).to be_a(String)
      expect(atm[:attributes]).to have_key(:address)
      expect(atm[:attributes][:address]).to be_a(String)
      expect(atm[:attributes]).to have_key(:lat)
      expect(atm[:attributes][:lat]).to be_a(String)
      expect(atm[:attributes]).to have_key(:lon)
      expect(atm[:attributes][:lon]).to be_a(String)
      expect(atm[:attributes]).to have_key(:distance)
      expect(atm[:attributes][:distance]).to be_a(String)
    end
  end

  it "sends a list of nearest atms to specific market (happy 200) - valid with data (single)" do
    market = create(:market, lat: 27.648973, lon: -97.519600)
    headers = {"CONTENT_TYPE" => "application/json"}

    get "/api/v0/markets/#{market.id}/nearest_atms"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    atm_data = parsed_json[:data]

    expect(atm_data).to be_a(Array)
    expect(atm_data.count).to eq(1)

    expect(atm_data.first).to be_a (Hash)
    expect(atm_data.first).to have_key(:id)
    expect(atm_data.first[:id]).to be(nil)  
    expect(atm_data.first).to have_key(:type)
    expect(atm_data.first[:type]).to be_a(String)
    expect(atm_data.first).to have_key(:attributes)
    expect(atm_data.first[:attributes]).to be_a(Hash)

    expect(atm_data.first[:attributes]).to have_key(:name)
    expect(atm_data.first[:attributes][:name]).to be_a(String)
    expect(atm_data.first[:attributes]).to have_key(:address)
    expect(atm_data.first[:attributes][:address]).to be_a(String)
    expect(atm_data.first[:attributes]).to have_key(:lat)
    expect(atm_data.first[:attributes][:lat]).to be_a(String)
    expect(atm_data.first[:attributes]).to have_key(:lon)
    expect(atm_data.first[:attributes][:lon]).to be_a(String)
    expect(atm_data.first[:attributes]).to have_key(:distance)
    expect(atm_data.first[:attributes][:distance]).to be_a(String)
  end

  it "sends a list of nearest atms to specific market (happy 200) - valid without data" do
    market = create(:market)
    headers = {"CONTENT_TYPE" => "application/json"}

    get "/api/v0/markets/#{market.id}/nearest_atms"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    market_data = parsed_json[:data]

    expect(market_data).to be_a(Array)
    expect(market_data.empty?).to be(true)
  end

  it "doesn't send a list of nearest atms to specific market (sad 404)" do
    get "/api/v0/markets/123123123123/nearest_atms"

    expect(response).not_to be_successful
    expect(response.status).to eq(404)

    parsed_json = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_json[:errors]).to be_a(Array)
    expect(parsed_json[:errors].first[:status]).to eq("404")
    expect(parsed_json[:errors].first[:title]).to eq("Couldn't find Market with 'id'=123123123123")
  end
end