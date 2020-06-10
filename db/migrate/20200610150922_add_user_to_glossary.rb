class AddUserToGlossary < ActiveRecord::Migration[6.0]
  def change
    add_column :glossaries, :user_id, :integer, default: 1
  end
end
