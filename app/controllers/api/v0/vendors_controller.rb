class Api::V0::VendorsController < ApplicationController
  def show
    begin
      @vendor = Vendor.find(params["id"])
      render json: VendorSerializer.new(@vendor)      
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