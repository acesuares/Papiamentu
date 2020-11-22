class AddUserToRecording < ActiveRecord::Migration[6.0]
  def change
    add_column :recordings, :user_id, :integer, default: 1
  end
end
