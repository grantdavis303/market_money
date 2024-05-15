class Vendor < ApplicationRecord
  validates_presence_of :name,
                        :description, 
                        :contact_name, 
                        :contact_phone

  validates :credit_accepted, inclusion: [true, false]

  has_many :market_vendors
  has_many :markets, through: :market_vendors
end