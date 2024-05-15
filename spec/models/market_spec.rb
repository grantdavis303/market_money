require 'rails_helper'

RSpec.describe Market, type: :model do
  describe "relationships" do
    it { should have_many(:market_vendors) }
    it { should have_many(:vendors).through(:market_vendors) }
  end

  describe "#methods" do
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