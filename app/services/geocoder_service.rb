# frozen_string_literal: true

require 'httparty'
require 'json'

class GeocoderService
  # Class Methods
  def self.geocode_city(city, state)
    options = {
      query: {
        q: "#{city},#{state},US",
        limit: 1,
        appid: ENV['GEOCODER_API_KEY']
      }
    }

    response = HTTParty.get('http://api.openweathermap.org/geo/1.0/direct', options)
    data = JSON.parse(response.body)
    [data[0]['lat'], data[0]['lon']] if data[0]
  end

  def self.create_request(city, state)
    options = {
      q: "#{city},#{state},US",
      limit: 1,
      appid: ENV['GEOCODER_API_KEY']
    }

    Typhoeus::Request.new('http://api.openweathermap.org/geo/1.0/direct', params: options)
  end

  # Instance Methods
  attr_accessor :results

  def initialize
    @hydra = Typhoeus::Hydra.hydra
    @results = []
  end

  def run_hydra
    @hydra.run
  end

  def create_and_add_request_to_hydra(city, state_two_letter)
    req = self.class.create_request(city, state_two_letter)
    req.on_complete do |response|
      data = JSON.parse(response.body)
      if data[0] && data[0]['lon'] && data[0]['lat']
        lon = data[0]['lon']
        lat = data[0]['lat']
        @results << [lon, lat, city, state_two_letter]
      end
    end
    @hydra.queue req
  end
end
