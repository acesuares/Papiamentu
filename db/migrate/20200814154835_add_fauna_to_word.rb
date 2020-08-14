class AddFaunaToWord < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :is_fauna, :integer, default: 1
    add_column :words, :scientific_name, :string
  end
end
