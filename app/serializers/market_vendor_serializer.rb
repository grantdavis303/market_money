class MarketVendorSerializer
  include JSONAPI::Serializer
  attributes :market_id, :vendor_id

  def message
    {
      "message": "Successfully added vendor to market"
    }
  end
end
