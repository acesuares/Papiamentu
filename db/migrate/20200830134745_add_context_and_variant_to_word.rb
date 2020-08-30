class AddContextAndVariantToWord < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :context, :text
    add_column :words, :varianten, :string
  end
end
