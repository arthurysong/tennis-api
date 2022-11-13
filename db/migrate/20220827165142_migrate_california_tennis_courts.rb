# frozen_string_literal: true

class MigrateCaliforniaTennisCourts < ActiveRecord::Migration[7.0]
  def change
    TennisCourtsMigrator.query_and_insert_tennis_courts
  end
end
