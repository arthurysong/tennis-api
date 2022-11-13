# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :tennis_court, null: false
      t.text :comment
      t.integer :rating
      t.string :device_id

      t.timestamps
    end
  end
end
