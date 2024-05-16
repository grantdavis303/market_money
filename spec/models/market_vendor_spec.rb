require 'rails_helper'

RSpec.describe MarketVendor, type: :model do
  describe "validations" do
    it { should validate_presence_of(:market_id) }
    it { should validate_presence_of(:vendor_id) }
    #it { should validate_presence_of(:already_exists).on(:create) }
  end

  describe "relationships" do
    it { should belong_to(:market) }
    it { should belong_to(:vendor) }
  end

  # Add Model Test for already_exists
  # Add Model Test for already_exists(args)
end