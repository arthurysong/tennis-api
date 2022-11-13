# frozen_string_literal: true

class ReportSerializer < ActiveModel::Serializer
  attributes :id, :status, :created_at

  belongs_to :tennis_court
end
