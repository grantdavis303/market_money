require 'rails_helper'
 
describe 'APi marketvendor' do
  it "" do
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
  end
end