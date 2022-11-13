# frozen_string_literal: true

require 'httparty'
require 'json'
require 'open-uri'

class ScrapeService
  def self.ca_cities
    doc = Nokogiri::HTML(URI.open('https://simple.wikipedia.org/wiki/List_of_cities_and_towns_in_California'))

    cities = []

    doc.css('th a').each do |link|
      regex = Regexp.new('[A-Z][a-z]*').freeze
      cities << link.content if regex =~ link.content
    end
    cities
  end

  def self.get_cities(state)
    # state input must be in lower case full state name

    doc = Nokogiri::HTML(URI.open("https://www.countryaah.com/alphabetical-list-of-cities-and-towns-in-#{state}/"))
    cities = []

    ul_element = doc.css('main article div.entry-content ul').first
    ul_element.css('li').each do |link|
      cities << link.content.split(',').first
    end
    cities
  end
end
