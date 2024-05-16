class Api::V0::MarketVendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
  
  def index
      @market = Market.find(params["market_id"])
      render json: VendorSerializer.new(@market.vendors)
  end

  def create
    market = params[:market_vendor][:market_id]
    vendor = params[:market_vendor][:vendor_id]
    render json: MarketVendorSerializer.new(MarketVendor.create!(market_id: market, vendor_id: vendor)).message, status: 201
  end

  def destroy
    #binding.pry
  end

  private def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json, status: :not_found
  end

  private def invalid_record(exception) # Validation failed: Market must exist    
    if exception.message.include?("already exists")
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422)).serialize_json_detail, status: :unprocessable_entity
    elsif exception.message.include?("can't be blank")
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400)).serialize_json_detail, status: :bad_request
    else
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json_detail, status: :not_found
    end
  end
end