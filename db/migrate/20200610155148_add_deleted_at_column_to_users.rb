class AddDeletedAtColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :deleted_at, :datetime, default: nil
    add_column :users, :deleted, :integer, default: 1
    add_column :users, :deleted_by, :integer, default: nil

  end
end
