class MarketVendor < ApplicationRecord
  belongs_to :market
  belongs_to :vendor

  validate :already_exists, on: :create

  def already_exists
    
    require 'pry' ; binding.pry
    # if market_id.exists? && vendor_id.exists?

    # end
  end
end