require 'rails_helper'

describe "Vendors API" do
  # User Story 4 - Happy Path
  it "sends back a single vendor (happy)" do
    vendor = create(:vendor)

    get "/api/v0/vendors/#{vendor.id}"

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    vendor_data = parsed_json[:data]

    expect(response.code).to eq("200")
    expect(response).to be_successful

    expect(vendor_data).to have_key(:id)
    expect(vendor_data[:id]).to be_a(String)  
    expect(vendor_data).to have_key(:type)
    expect(vendor_data[:type]).to be_a(String)
    expect(vendor_data).to have_key(:attributes)
    expect(vendor_data[:attributes]).to be_a(Hash)
    expect(vendor_data[:attributes]).to have_key(:name)
    expect(vendor_data[:attributes][:name]).to be_a(String)
    expect(vendor_data[:attributes]).to have_key(:description)
    expect(vendor_data[:attributes][:description]).to be_a(String)
    expect(vendor_data[:attributes]).to have_key(:contact_name)
    expect(vendor_data[:attributes][:contact_name]).to be_a(String)
    expect(vendor_data[:attributes]).to have_key(:contact_phone)
    expect(vendor_data[:attributes][:contact_phone]).to be_a(String)
    expect(vendor_data[:attributes]).to have_key(:credit_accepted)
    expect(vendor_data[:attributes][:credit_accepted]).to be(true).or be(false)
  end

  # User Story 4 - Sad Path
  it "sends back a single vendor (sad)" do
    get "/api/v0/vendors/123123123123"

    expect(response.code).to eq("404")
    expect(response).not_to be_successful

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq("Couldn't find Vendor with 'id'=123123123123")
  end
end