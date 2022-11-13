class AddColumnsToTennisCourts < ActiveRecord::Migration[7.0]
  def change
    add_column :tennis_courts, :street_address_1, :string
    add_column :tennis_courts, :street_address_2, :string
    add_column :tennis_courts, :city, :string
    add_column :tennis_courts, :state, :string
    add_column :tennis_courts, :zip, :string

    TennisCourt.find_each do |tc|
      split = tc.address.split(', ')
      street_address_1 = split[-4]
      city = split[-3]
      state = split[-2].split(' ')[0]
      zip = split[-2].split(' ')[1]

      tc.update(street_address_1: street_address_1, city: city, state: state, zip: zip)
    end
  end
end
