# frozen_string_literal: true

class Review < ApplicationRecord
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  belongs_to :tennis_court

  # TODO: add some validations, we need required comment? of a specific length?
end
