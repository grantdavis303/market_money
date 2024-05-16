require 'rails_helper'

describe "MarketVendors API" do

  # User Story 8 - Happy Path - Successful Create
  it "creates a market vendor (happy 201)" do
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

  # User Story 8 - Sad Path 1 - Validation faiiled: Market must exist
  it "doesn't create a market vendor (sad 404)" do
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

  # User Story 8 - Sad Path 2 - Validation failed: Market vendor asociation between market with market_id and vendor_id already exists
  it "doesn't create a market vendor (sad 422)" do
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
    expect(data[:errors].first[:detail]).to eq("Validation failed: Market vendor asociation between market with market_id=#{market.id} and vendor_id=#{vendor.id} already exists")
  end

  # User Story 8 - Sad Path 3 - Market can't be blank
  it "doesn't create a market vendor (sad 400) - market can't be blank" do
    market = create(:market)
    vendor = create(:vendor)
    market_vendor_params = ({
      vendor_id: vendor.id
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    
    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Validation failed: Market can't be blank, Market must exist")
  end

  # User Story 8 - Sad Path 34 - Vendor can't be blank
  it "doesn't create a market vendor (sad 400) - vendor can't be blank" do
    market = create(:market)
    vendor = create(:vendor)
    market_vendor_params = ({
      market_id: market.id
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    
    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Validation failed: Vendor can't be blank, Vendor must exist")
  end

  # User Story 8 - Sad Path 5 - Both can't be blank
  it "doesn't create a market vendor (sad 400) - both can't be blank" do
    market = create(:market)
    vendor = create(:vendor)
    market_vendor_params = ({})
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    expect(response).not_to be_successful
    expect(response.status).to eq(400)
    
    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Validation failed: Market can't be blank, Vendor can't be blank, Market must exist, Vendor must exist")
  end















  # User Story 9 - Happy Path
  xit "deletes a market_vendor (happy)" do
    market = create(:market)
    vendor = create(:vendor)
    MarketVendor.create!(market_id: market.id, vendor_id: vendor.id)

    market_vendor_params = ({
      market_id: market.id,
      vendor_id: vendor.id
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    delete "/api/v0/market_vendors", headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    expect(response).to be_successful
    expect(response.status).to eq(204)

    #data = JSON.parse(response.body, symbolize_names: true)
  end

  # User Story 9 - Sad Path
  xit "deletes a market_vendor (sad)" do
  end
end