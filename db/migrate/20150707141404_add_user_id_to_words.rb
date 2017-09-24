class AddUserIdToWords < ActiveRecord::Migration
  def change
    add_column :words, :user_id, :integer, default: 2
  end
end
