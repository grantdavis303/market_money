require 'rails_helper'

RSpec.describe MarketVendor, type: :model do
  describe "relationships" do
    it { should belong_to(:market) }
    it { should belong_to(:vendor) }
  end
end