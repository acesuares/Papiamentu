class AddDescriptionToWord < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :description_pap_aw, :text
    add_column :words, :description_en, :text
    add_column :words, :description_es, :text
  end
end
