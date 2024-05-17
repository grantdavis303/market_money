require 'rails_helper'

RSpec.describe Atm do
  it "exists and can initialize" do
    atm_data = {
      name: "Grant",
      address: "1234 Wewatta Way, Denver, CO 80203",
      lat: 36.957,
      lon: -48.682,
      distance: 522.234 
    }
    atm = Atm.new(atm_data)

    expect(atm).to be_a Atm
    expect(atm.name).to eq("Grant")
    expect(atm.address).to eq("1234 Wewatta Way, Denver, CO 80203")
    expect(atm.lat).to eq(36.957)
    expect(atm.lon).to eq(-48.682)
    expect(atm.distance).to eq(522.234)
  end
end