class Api::V0::MarketSearchController < ApplicationController
  def index
    new_hash = Hash.new
    city = (new_hash[:city] = params[:city]) if params.include?(:city)
    state = (new_hash[:state] = params[:state]) if params.include?(:state)
    name = (new_hash[:name] = params[:name]) if params.include?(:name)

    if new_hash.keys.include?(:city) && new_hash.keys.include?(:name) && new_hash.keys.length == 2 || new_hash.keys.include?(:city) && new_hash.keys.length == 1
      render json: ErrorSerializer.new(ErrorMessage.new("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.", 422)).serialize_json_detail_search, status: :unprocessable_entity
    else
      string_array = Array.new
      string_array << "city ILIKE '%#{city}%'" if new_hash.include?(:city)
      string_array << "state ILIKE '%#{state}%'" if new_hash.include?(:state)
      string_array << "name ILIKE '%#{name}%'" if new_hash.include?(:name)
      search_string = string_array.to_s.gsub(/,/, ' AND').delete "[]\"/"
      render json: MarketSerializer.new(Market.search_by_string(search_string)), status: 200
    end
  end
end