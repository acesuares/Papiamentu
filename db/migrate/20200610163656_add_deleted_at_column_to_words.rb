class AddDeletedAtColumnToWords < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :deleted_at, :datetime, default: nil
  end
end
