# frozen_string_literal: true

class TennisCourt < ApplicationRecord
  has_paper_trail

  enum court_type: %i[hard clay grass synthetic]

  scope :master, -> { where(type: nil) }

  # * callbacks
  before_save :set_point_data

  # * validations
  validates :google_place_id, uniqueness: { message: 'should be unique', scope: :type }, if: -> { type.nil? }

  # * associations
  has_many :reports, dependent: :destroy
  accepts_nested_attributes_for :reports

  has_many :reviews, dependent: :destroy
  accepts_nested_attributes_for :reviews, allow_destroy: true

  has_many :tennis_court_suggestions, foreign_key: 'master_id', dependent: :destroy
  accepts_nested_attributes_for :tennis_court_suggestions, allow_destroy: true

  SEARCH_RADIUS = 10_000 # m

  def set_point_data
    self.lonlat = "POINT(#{long} #{lat})"
  end

  def self.create_from_results(results)
    import map_results_to_params(results)
  end

  def self.map_results_to_params(results)
    results.map do |r|
      { lat: r['geometry']['location']['lat'],
        long: r['geometry']['location']['lng'],
        name: r['name'],
        address: r['formatted_address'],
        google_place_id: r['place_id'] }
    end
  end

  def self.by_radius(lat, long)
    # active record chainable postgis query
    sql = "SELECT * FROM tennis_courts WHERE ST_Distance(lonlat, ST_WKTToSQL('POINT(#{long} #{lat})')) < #{SEARCH_RADIUS} "

    select('*').from("(#{sql}) as tennis_courts")
  end

  def average_rating
    @reviews ||= reviews.load
    return 0 if @reviews.empty?

    @reviews.sum(:rating) / @reviews.length
  end

  def num_reviews
    @reviews ||= reviews.load

    @reviews.length
  end
end
