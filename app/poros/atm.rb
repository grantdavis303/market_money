class Atm
  attr_reader :name, :address, :lat, :lon, :distance

  def initialize(data)
    @name = data[:name]
    @address = data[:address]
    @lat = data[:lat]
    @lon = data[:lon]
    @distance = data[:distance]
  end
end