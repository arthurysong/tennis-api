# frozen_string_literal: true

class Report < ApplicationRecord
  enum status: %i[many some full]

  belongs_to :tennis_court
end
