require 'rails_helper'

RSpec.describe Market, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:county) } 
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:lon) }
  end

  describe "relationships" do
    it { should have_many(:market_vendors) }
    it { should have_many(:vendors).through(:market_vendors) }
  end

  describe "#methods" do
    it "#search_by_string(args)" do
      market = create(:market, name: "Grant's Market")
      string = "name ILIKE '%gra%'"
      
      expect(Market.search_by_string(string).empty?).to eq(false)
      expect(Market.search_by_string(string)[0]).to eq(market)
    end

    it "#vendor_count" do
      market_list = create_list(:market, 1)
      market = market_list[0]
      vendors = create_list(:vendor, 5)
      vendors.each do |vendor|
        MarketVendor.create!(market_id: market.id, vendor_id: vendor.id)
      end

      expect(market.vendor_count).to eq(5)
    end
  end
end