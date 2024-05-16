class Api::V0::VendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

  def show
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end

  def create
    render json: VendorSerializer.new(Vendor.create!(vendor_params)), status: 201
  end

  def update
    render json: VendorSerializer.new(Vendor.update!(params[:id], vendor_params)), status: 200      
  end

  def destroy
    @deleted_vendor = Vendor.find(params[:id])
    @deleted_vendor.market_vendors.each { |vendor| vendor.destroy }
    render json: Vendor.delete(@deleted_vendor), status: 204
  end

  private def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end

  private def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json, status: :not_found
  end

  private def invalid_record(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400)).serialize_json, status: :bad_request
  end
end