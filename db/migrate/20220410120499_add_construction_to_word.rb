class AddConstructionToWord < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :is_construction, :integer, default: 1
  end
end
