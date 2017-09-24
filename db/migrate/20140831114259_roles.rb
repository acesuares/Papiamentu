class Roles < ActiveRecord::Migration
  def up
    create_table "roles", :force => true do |t|
      t.string   "name"
      t.text	 :description
      t.timestamps
    end
  
    create_table "roles_users", :id => false, :force => true do |t|
      t.integer "role_id"
      t.integer "user_id"
    end
  end

  def down
  end
end
