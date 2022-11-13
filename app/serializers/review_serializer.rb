# frozen_string_literal: true

class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :comment, :created_at, :device_id

  belongs_to :tennis_court
end
