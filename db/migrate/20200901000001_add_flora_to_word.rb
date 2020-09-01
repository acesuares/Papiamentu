class AddFloraToWord < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :is_flora, :integer, default: 1
  end
end
