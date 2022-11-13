# frozen_string_literal: true

class TennisCourtSerializer < ActiveModel::Serializer
  attributes :id, :lat, :long, :name, :address, :google_place_id, :street_address_1, :street_address_2, :city, :state, :zip,
             :num_courts, :lights, :time_lights_off, :court_type

  # calculated
  attributes :average_rating, :num_reviews

  has_many :reports
  has_many :reviews

  def lat
    object.lat.to_f
  end

  def long
    object.long.to_f
  end
end
