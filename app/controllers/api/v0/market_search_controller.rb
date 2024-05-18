class Api::V0::MarketSearchController < ApplicationController
  def index
    hash = build_hash(params)
    if invalid_params_check(hash)
      render json: ErrorSerializer.new(ErrorMessage.new("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.", 422)).serialize_json_detail_search, status: :unprocessable_entity
    else
      search_string = build_string(hash)
      render json: MarketSerializer.new(Market.search_by_string(search_string)), status: 200
    end
  end

  private def invalid_params_check(hash)
    hash.keys.include?(:city) && hash.keys.include?(:name) && hash.keys.length == 2 || 
    hash.keys.include?(:city) && hash.keys.length == 1
  end

  private def build_hash(params)
    params_hash = Hash.new
    city = (params_hash[:city] = params[:city]) if params.include?(:city)
    state = (params_hash[:state] = params[:state]) if params.include?(:state)
    name = (params_hash[:name] = params[:name]) if params.include?(:name)
    params_hash
  end

  private def build_string(hash)
    string_array = Array.new
    string_array << "city ILIKE '%#{hash[:city]}%'" if hash.include?(:city)
    string_array << "state ILIKE '%#{hash[:state]}%'" if hash.include?(:state)
    string_array << "name ILIKE '%#{hash[:name]}%'" if hash.include?(:name)
    string_array.to_s.gsub(/,/, ' AND').delete "[]\"/"
  end
end