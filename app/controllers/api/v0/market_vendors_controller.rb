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
    if @deleted_market_vendor = MarketVendor.find_by(market_id: params[:market_vendor][:market_id], vendor_id: params[:market_vendor][:vendor_id])
      render json: MarketVendor.delete(@deleted_market_vendor), status: 204    
    else # Commenting out this else and the render will get the Postman tests to pass...
      render json: ErrorSerializer.new(ErrorMessage.new("No MarketVendor with market_id=#{params[:market_vendor][:market_id]} AND vendor_id=#{params[:market_vendor][:vendor_id]}", 404)).serialize_json_detail, status: 404
    end
  end

  private def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json, status: :not_found
  end

  private def invalid_record(exception)
    if exception.message.include?("already exists")
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422)).serialize_json_detail, status: :unprocessable_entity
    elsif exception.message.include?("can't be blank")
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400)).serialize_json_detail, status: :bad_request
    else
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json_detail, status: :not_found
    end
  end
end