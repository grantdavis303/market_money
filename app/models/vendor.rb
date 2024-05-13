class Vendor < ApplicationRecord
  has_many :market_vendors
  has_many :markets, through: :market_vendors
end