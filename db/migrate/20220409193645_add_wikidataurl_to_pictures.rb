class AddWikidataurlToPictures < ActiveRecord::Migration[6.0]
  def change
    add_column :pictures, :wikidata_url, :string
  end
end
