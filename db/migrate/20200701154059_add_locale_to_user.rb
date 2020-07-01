class AddLocaleToUser < ActiveRecord::Migration[6.0]
  def up
    remove_column :users, :locale
    add_column :users, :locale, :integer, default: 1
  end
end
