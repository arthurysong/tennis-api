# frozen_string_literal: true

class SetPointDataForTennisCourts < ActiveRecord::Migration[7.0]
  def change
    TennisCourt.find_each do |tc|
      tc.lonlat = "POINT(#{tc.long} #{tc.lat})"
      tc.save
    end
  end
end
