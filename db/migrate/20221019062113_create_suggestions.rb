# frozen_string_literal: true

class CreateSuggestions < ActiveRecord::Migration[7.0]
  def change
    add_column :tennis_courts, :type, :string
    add_reference :tennis_courts, :version
    add_reference :tennis_courts, :master, foreign_key: { to_table: :tennis_courts }
  end
end
