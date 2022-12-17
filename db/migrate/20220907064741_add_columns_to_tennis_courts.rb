# frozen_string_literal: true

class AddColumnsToTennisCourts < ActiveRecord::Migration[7.0]
  def change
    add_column :tennis_courts, :street_address_1, :string
    add_column :tennis_courts, :street_address_2, :string
    add_column :tennis_courts, :city, :string
    add_column :tennis_courts, :state, :string
    add_column :tennis_courts, :zip, :string
  end
end
