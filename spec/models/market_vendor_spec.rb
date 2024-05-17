require 'rails_helper'

RSpec.describe MarketVendor, type: :model do
  describe "validations" do
    it { should validate_presence_of(:market_id) }
    it { should validate_presence_of(:vendor_id) }
  end

  describe "relationships" do
    it { should belong_to(:market) }
    it { should belong_to(:vendor) }
  end

  describe "#methods" do
    it "#already_exists(args)" do
      market = create(:market)
      vendor1 = create(:vendor)
      vendor2 = create(:vendor)
      MarketVendor.create!(market_id: market.id, vendor_id: vendor1.id)
      expect(MarketVendor.already_exists(market.id, vendor1.id).empty?).to eq(false)
      expect(MarketVendor.already_exists(market.id, vendor2.id).empty?).to eq(true)
    end

    it "#already_exists" do
      market = create(:market)
      vendor = create(:vendor)
      MarketVendor.create!(market_id: market.id, vendor_id: vendor.id)
      invalid = MarketVendor.new(market_id: market.id, vendor_id: vendor.id)
      expect(invalid).not_to be_valid
    end
  end
end