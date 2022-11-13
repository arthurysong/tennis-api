# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'httparty'

class GooglePlacesService
  @textsearch_url = 'https://maps.googleapis.com/maps/api/place/textsearch/json'
  # @results = []

  def self.query_courts(lat, long, next_page_token = nil)
    data = textsearch_call(lat, long, next_page_token)
    results = data['results']

    return results unless data['next_page_token']

    sleep 2
    results + query_courts(lat, long, data['next_page_token'])
  end

  def self.textsearch_call(lat, long, next_page_token = nil)
    options = {
      query: {
        pagetoken: next_page_token,
        location: "#{lat},#{long}",
        radius: 1000,
        query: 'tennis courts',
        key: ENV['GOOGLE_API_KEY']
      }
    }

    response = HTTParty.get(@textsearch_url, options)
    JSON.parse(response.body)
  end
end
