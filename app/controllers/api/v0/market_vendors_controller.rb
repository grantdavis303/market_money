class Api::V0::MarketVendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  
  def index
      @market = Market.find(params["market_id"])
      render json: VendorSerializer.new(@market.vendors)
  end

  def create
    market = params[:market_vendor][:market_id]
    vendor = params[:market_vendor][:vendor_id]
    render json: MarketVendorSerializer.new(
    MarketVendor.create!(market_id: market, vendor_id: vendor)), status: 201
  end

  private def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
      .serialize_json, status: :not_found
  end
end