require 'rails_helper'
 
describe 'APi marketvendor' do
  #user story 8
  it "creates a market vendor (happy)" do
    market = create(:market)
    vendor = create(:vendor)
    market_vendor_params = ({
      market_id: market.id,
      vendor_id: vendor.id
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    expect(response).to be_successful   
    expect(response.status).to eq(201)

    data = JSON.parse(response.body, symbolize_names: true)
    expect(data[:message]).to eq("Successfully added vendor to market")
  end

  #user story 8
  it "creates a market vendor (sad)" do
    market = create(:market)
    vendor = create(:vendor)
    market_vendor_params = ({
      market_id: 123123123123,
      vendor_id: vendor.id
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)
    
    expect(response).not_to be_successful
    expect(response.status).to eq(404)
    
    data = JSON.parse(response.body, symbolize_names: true)
    
    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Validation failed: Market must exist")
  end

  it "creates a market vendor (sad)" do
    market = create(:market)
    vendor = create(:vendor)
    MarketVendor.create!(market_id: market.id, vendor_id: vendor.id)
    market_vendor_params = ({
      market_id: market.id,
      vendor_id: vendor.id
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)
    
    expect(response).not_to be_successful
    expect(response.status).to eq(422)
    
    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Validation failed: Market vendor asociation between market with market_id=70 and vendor_id=1150 already exists")
  end
end