class AddLicenseAndArtistToPicture < ActiveRecord::Migration[6.0]
  def change
    add_column :pictures, :artist, :string
    add_column :pictures, :license_id, :integer, default: 1
  end
end
