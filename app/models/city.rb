# frozen_string_literal: true

class City < ApplicationRecord
  def self.create_from_results(results)
    import map_results_to_params(results)
  end

  def self.map_results_to_params(city_array)
    city_array.map do |city|
      { lat: city[0],
        long: city[1],
        name: city[2].titlecase,
        state: city[3] }
    end
  end

  def self.dedup
    ids = self.select('MIN(id) as id').group(:name, :state).collect(&:id)
    where('id NOT IN (?)', ids).destroy_all
  end
end
