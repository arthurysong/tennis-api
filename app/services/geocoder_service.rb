# frozen_string_literal: true

require 'httparty'
require 'json'

class GeocoderService
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
end
