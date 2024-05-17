require 'rails_helper'

describe "Market Search API" do

  # User Story 10 - Happy Path
  it "search for markets with params (happy 200) - valid with data (single)" do
    market_1 = create(:market, name: "Nob Hill Growers' Market", city: "Albuquerque", state: "New Mexico")
    market_2 = create(:market, name: "Bridget", city: "Tampa", state: "Florida")
    markets = create_list(:market, 4)
    headers = {"CONTENT_TYPE" => "application/json"}

    expect(Market.count).to eq(6)

    get "/api/v0/markets/search?city=albuquerque&state=new Mexico&name=Nob hill"
    
    expect(response).to be_successful   
    expect(response.status).to eq(200)

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    market_data = parsed_json[:data]

    expect(market_data).to be_a(Array)
    
    expect(market_data.first).to be_a (Hash)
    expect(market_data.first).to have_key(:id)
    expect(market_data.first[:id]).to be_a(String)  
    expect(market_data.first).to have_key(:type)
    expect(market_data.first[:type]).to be_a(String)
    expect(market_data.first).to have_key(:attributes)
    expect(market_data.first[:attributes]).to be_a(Hash)

    expect(market_data.first[:attributes]).to have_key(:name)
    expect(market_data.first[:attributes][:name]).to be_a(String)
    expect(market_data.first[:attributes]).to have_key(:street)
    expect(market_data.first[:attributes][:street]).to be_a(String)
    expect(market_data.first[:attributes]).to have_key(:city)
    expect(market_data.first[:attributes][:city]).to be_a(String)
    expect(market_data.first[:attributes]).to have_key(:county)
    expect(market_data.first[:attributes][:county]).to be_a(String)
    expect(market_data.first[:attributes]).to have_key(:state)
    expect(market_data.first[:attributes][:state]).to be_a(String)
    expect(market_data.first[:attributes]).to have_key(:zip)
    expect(market_data.first[:attributes][:zip]).to be_a(String)
    expect(market_data.first[:attributes]).to have_key(:lat)
    expect(market_data.first[:attributes][:lat]).to be_a(String)
    expect(market_data.first[:attributes]).to have_key(:lon)
    expect(market_data.first[:attributes][:lon]).to be_a(String)
    expect(market_data.first[:attributes]).to have_key(:vendor_count)
    expect(market_data.first[:attributes][:vendor_count]).to be_a(Integer)
  end

  it "search for markets with params (happy 200) - valid with data (multiple)" do
    market_1 = create(:market, name: "Luis' Cool Market", city: "Denver", state: "Colorado")
    market_2 = create(:market, name: "Grant's Cool Market", city: "Denver", state: "Colorado")
    markets = create_list(:market, 4)
    headers = {"CONTENT_TYPE" => "application/json"}

    expect(Market.count).to eq(6)

    get "/api/v0/markets/search?city=den&state=Colo&name=market"
    
    expect(response).to be_successful   
    expect(response.status).to eq(200)

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    market_data = parsed_json[:data]

    expect(market_data).to be_a(Array)
    
    market_data.each do |market|
      expect(market).to be_a (Hash)
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

  it "search for markets with params (happy 200) - valid without data" do
    market_1 = create(:market, name: "Nob Hill Growers' Market", city: "Albuquerque", state: "New Mexico")
    market_2 = create(:market, name: "Tampa Bay Growers' Club", city: "Tampa", state: "Florida")
    headers = {"CONTENT_TYPE" => "application/json"}

    get "/api/v0/markets/search?city=houston&state=texas&name=grant"
    
    expect(response).to be_successful   
    expect(response.status).to eq(200)

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    market_data = parsed_json[:data]

    expect(market_data).to be_a(Array)
    expect(market_data.empty?).to be(true)
  end

  it "doesn't search for markets with params (sad 422) - city" do
    market_1 = create(:market, name: "Nob Hill Growers' Market", city: "Albuquerque", state: "New Mexico")
    
    get "/api/v0/markets/search?city=albuquerque"
    
    expect(response).not_to be_successful   
    expect(response.status).to eq(422)

    parsed_json = JSON.parse(response.body, symbolize_names: true) 

    expect(parsed_json[:errors]).to be_a(Array)
    expect(parsed_json[:errors].first[:detail]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
  end

  it "doesn't search for markets with params (sad 422) - city and name" do
    market_1 = create(:market, name: "Nob Hill Growers' Market", city: "Albuquerque", state: "New Mexico")
    
    get "/api/v0/markets/search?city=albuquerque&name=Nob hill"

    expect(response).not_to be_successful   
    expect(response.status).to eq(422)

    parsed_json = JSON.parse(response.body, symbolize_names: true) 

    expect(parsed_json[:errors]).to be_a(Array)
    expect(parsed_json[:errors].first[:detail]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
  end
end