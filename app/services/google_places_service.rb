# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'httparty'

class GooglePlacesService
  @textsearch_url = 'https://maps.googleapis.com/maps/api/place/textsearch/json'

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

  def self.add_request_to_hydra(lat, long, hydra, next_page_token = nil)
    req = create_req(lat, long, next_page_token)

    hydra.queue(req)
    req.on_complete do |r|
      data = JSON.parse(r.body)
      # debugger
      # puts data
      TennisCourt.create_from_results(data['results'])

      if data['next_page_token']
        sleep 2
        add_request_to_hydra(lat, long, hydra, data['next_page_token'])
      end
    end
  end

  def self.create_req(lat, long, next_page_token)
    params = {
      pagetoken: next_page_token,
      location: "#{lat},#{long}",
      radius: 1000,
      query: 'tennis courts',
      key: ENV['GOOGLE_API_KEY']
    }

    Typhoeus::Request.new(@textsearch_url, params: params)
  end

  attr_accessor :results

  def initialize
    @results = []
    @hydra = Typhoeus::Hydra.hydra
  end

  def add_request_to_hydra(lat, long, next_page_token = nil)
    req = self.class.create_req(lat, long, next_page_token)

    @hydra.queue(req)
    req.on_complete do |r|
      data = JSON.parse(r.body)
      @results += data['results']

      if data['next_page_token']
        sleep 2
        add_request_to_hydra(lat, long, data['next_page_token'])
      end
    end
  end

  def run_hydra
    @hydra.run
  end
end
