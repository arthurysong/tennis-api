# frozen_string_literal: true

class RunMigratorForAllCities < ActiveRecord::Migration[7.0]
  def change
    TennisCourtsMigrator.migrate_tennis_courts_in_usa # split this up into different migrations by cities cause it takes a while... or think of a way to speed up the migration.. we barely got to Florida last run before we had to restart it.
  end
end
