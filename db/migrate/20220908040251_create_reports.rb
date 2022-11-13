# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.references :tennis_court, null: false
      t.integer :status

      t.timestamps
    end
  end
end
