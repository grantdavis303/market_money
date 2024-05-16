class MarketVendor < ApplicationRecord
  validates_presence_of :market_id,
                        :vendor_id

  validate :already_exists, on: :create
  
  belongs_to :market
  belongs_to :vendor

  def self.already_exists(id_1, id_2)
    where(market_id: id_1, vendor_id: id_2)
  end

  def already_exists
    if MarketVendor.already_exists(market_id, vendor_id).empty? != true
      errors.add(:base, "Market vendor asociation between market with market_id=#{market_id} and vendor_id=#{vendor_id} already exists")
    end
  end
end