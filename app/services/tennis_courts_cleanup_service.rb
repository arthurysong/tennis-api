# frozen_string_literal: true

class TennisCourtsCleanupService
  def self.set_point_data
    TennisCourt.master.where(lonlat: nil).find_each do
      TennisCourt.find_each do |tc|
        tc.lonlat = "POINT(#{tc.long} #{tc.lat})"
        tc.save
      end
    end
  end

  def self.set_address_data
    TennisCourt.master.where(state: nil).where.not(address: nil).find_each do |tc|
      split = tc.address.split(', ')
      street_address_1 = split[-4]
      city = split[-3]
      state = split[-2].split(' ')[0]
      zip = split[-2].split(' ')[1]

      tc.update(street_address_1: street_address_1, city: city, state: state, zip: zip)
    end
  end

  def self.delete_duplicates
    ids = TennisCourt.master.select('MIN(id) as id').group(:google_place_id).collect(&:id)
    TennisCourt.master.where('id NOT IN (?)', ids).destroy_all
  end

  def self.remove_non_google_locations
    TennisCourt.master.where(google_place_id: nil).destroy_all
  end
end
