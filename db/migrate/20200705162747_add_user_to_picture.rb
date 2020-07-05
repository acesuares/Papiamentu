class AddUserToPicture < ActiveRecord::Migration[6.0]
  def change
    add_column :pictures, :user_id, :integer, default: 1
  end
end
