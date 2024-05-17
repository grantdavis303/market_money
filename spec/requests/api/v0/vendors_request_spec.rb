require 'rails_helper'

describe "Vendors API" do
  it "sends back a single vendor (happy)" do
    vendor = create(:vendor)

    get "/api/v0/vendors/#{vendor.id}"

    expect(response).to be_successful    
    expect(response.status).to eq(200)

    parsed_json = JSON.parse(response.body, symbolize_names: true)
    vendor_data = parsed_json[:data]

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

  it "sends back a single vendor (sad)" do
    get "/api/v0/vendors/123123123123"

    expect(response).not_to be_successful
    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq("Couldn't find Vendor with 'id'=123123123123")
  end

  it "creates a new vendor (happy)" do
    vendor_params = ({
      name: "Grant's Newly Created Vendor - Happy",
      description: "Lorem ipsum", 
      contact_name: "Grant",
      contact_phone: "1-888-295-2150",
      credit_accepted: true
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)
    
    created_vendor = Vendor.last

    expect(response).to be_successful
    expect(response.status).to eq(201)

    expect(created_vendor.name).to eq(vendor_params[:name])
    expect(created_vendor.description).to eq(vendor_params[:description])
    expect(created_vendor.contact_name).to eq(vendor_params[:contact_name])
    expect(created_vendor.contact_phone).to eq(vendor_params[:contact_phone])
    expect(created_vendor.credit_accepted).to eq(vendor_params[:credit_accepted])
  end

  it "creates a new vendor (sad)" do
    vendor_params = ({
      name: "Grant's Newly Created Vendor - Sad",
      description: "Lorem ipsum", 
      credit_accepted: true
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v0/vendors", headers: headers, params: JSON.generate(vendor: vendor_params)

    expect(response).not_to be_successful    
    expect(response.status).to eq(400)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("400")
    expect(data[:errors].first[:title]).to eq("Validation failed: Contact name can't be blank, Contact phone can't be blank")
  end

  it "updates a vendor (happy)" do
    vendor = create(:vendor)
    previous_name = Vendor.last.name
    vendor_params = ({
      name: "Grant's Edited Vendor - Happy",
      description: "If you're reading this then you're awesome!"
    })
    headers = {"CONTENT_TYPE" => "application/json"}
    
    patch "/api/v0/vendors/#{vendor.id}", headers: headers, params: JSON.generate({vendor: vendor_params})
    
    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    vendor = Vendor.find_by(id: vendor.id)

    expect(vendor.name).to_not eq(previous_name)
    expect(vendor.name).to eq("Grant's Edited Vendor - Happy")
  end

  it "updates a vendor (sad 1)" do   
    vendor = create(:vendor)
    vendor_params = ({
      name: "Grant's Edited Vendor - Sad",
      description: "If you're reading this then you're awesome!"
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v0/vendors/123123123123", headers: headers, params: JSON.generate({vendor: vendor_params})

    expect(response).not_to be_successful
    expect(response.status).to eq(404)
    
    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq("Couldn't find Vendor with 'id'=123123123123")
  end

  it "updates a vendor (sad 2)" do
    vendor = create(:vendor)
    vendor_params = ({
      name: "",
      credit_accepted: false
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v0/vendors/#{vendor.id}", headers: headers, params: JSON.generate({vendor: vendor_params})

    expect(response).not_to be_successful
    expect(response.status).to eq(400)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("400")
    expect(data[:errors].first[:title]).to eq("Validation failed: Name can't be blank")
  end

  it "deletes a vendor (happy)" do
    market = create(:market)
    vendor = create(:vendor)
    MarketVendor.create!(market_id: market.id, vendor_id: vendor.id)

    expect(Vendor.count).to eq(1)

    delete "/api/v0/vendors/#{vendor.id}"

    expect(response).to be_successful
    expect(response.status).to eq(204)

    expect(Vendor.count).to eq(0)
    expect{Vendor.find(vendor.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "deletes a vendor (sad)" do    
    delete "/api/v0/vendors/123123123123"

    expect(response).not_to be_successful
    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:status]).to eq("404")
    expect(data[:errors].first[:title]).to eq("Couldn't find Vendor with 'id'=123123123123")
  end
end