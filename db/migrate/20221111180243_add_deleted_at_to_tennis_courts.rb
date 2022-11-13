class AddDeletedAtToTennisCourts < ActiveRecord::Migration[7.0]
  def change
    add_column :tennis_courts, :deleted_at, :datetime
    add_index :tennis_courts, :deleted_at
  end
end
