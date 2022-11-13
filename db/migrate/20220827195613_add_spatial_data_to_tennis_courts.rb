# frozen_string_literal: true

class AddSpatialDataToTennisCourts < ActiveRecord::Migration[7.0]
  def change
    add_column :tennis_courts, :lonlat, :st_point, geographic: true
    add_index :tennis_courts, :lonlat, using: :gist
  end
end
