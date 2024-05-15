class Api::V0::MarketVendorsController < ApplicationController
  def index
    begin
      @market = Market.find(params["market_id"])
      render json: VendorSerializer.new(@market.vendors)
    rescue ActiveRecord::RecordNotFound => exception
      render json: {
        errors: [
          {
            status: "404",
            title: exception.message
          }
        ]
      }, status: :not_found
    end
  end
end