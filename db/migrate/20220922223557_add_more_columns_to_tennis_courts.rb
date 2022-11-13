# frozen_string_literal: true

class AddMoreColumnsToTennisCourts < ActiveRecord::Migration[7.0]
  def change
    add_column :tennis_courts, :num_courts, :integer
    add_column :tennis_courts, :lights, :boolean
    add_column :tennis_courts, :time_lights_off, :time
    add_column :tennis_courts, :court_type, :integer
  end
end
