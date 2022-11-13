# frozen_string_literal: true

class CreateTennisCourts < ActiveRecord::Migration[7.0]
  def change
    create_table :tennis_courts do |t|
      t.decimal :lat, precision: 8, scale: 6
      t.decimal :long, precision: 9, scale: 6
      t.string :name
      t.string :address
      t.string :google_place_id

      t.timestamps
    end
  end
end
