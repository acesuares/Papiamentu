class AddCommentsToWords < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :comment, :text
  end
end
