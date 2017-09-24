class AddChoicesToUser < ActiveRecord::Migration
  def change
    add_column :users, :new_words, :integer, default: 0
    add_column :users, :active, :integer, default: 1
    add_column :users, :own_words, :integer, default: 0
    add_column :users, :most_voted, :integer, default: 0
  end
end
