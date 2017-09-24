class AddDeletedToWords < ActiveRecord::Migration
  def change
    add_column :words, :deleted, :integer, default: 1
    add_column :words, :deleted_by, :integer, default: nil
  end
end
