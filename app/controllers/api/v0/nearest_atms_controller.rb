class Api::V0::NearestAtmsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def index
    market = Market.find(params[:id])
    latitude = market.lat
    longitude = market.lon
    radius = 10000
    limit = 12
    poi_id = 7397 # Found with api.tomtom.com/search/2/poiCategories.json?

    api_response = Faraday.get("https://api.tomtom.com/search/2/nearbySearch/.json?lat=#{latitude}&lon=#{longitude}&limit=#{limit}&radius=#{radius}&categorySet=#{poi_id}&view=Unified&relatedPois=off&key=#{Rails.application.credentials.tomtom[:key]}")
    
    formatted_json = JSON.parse(api_response.body, symbolize_names: true)
    query_results = formatted_json[:results]

    @new_atm_objects = Array.new
    query_results.each do |query_result|
      atm_data = {
        name: query_result[:poi][:name],
        address: query_result[:address][:freeformAddress],
        lat: query_result[:position][:lat],
        lon: query_result[:position][:lon],
        distance: query_result[:dist]
      }
      new_machine = Atm.new(atm_data)
      @new_atm_objects << new_machine
    end

    render json: AtmSerializer.new.serialize_json(@new_atm_objects), status: 200
  end

  private def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json, status: :not_found
  end
end