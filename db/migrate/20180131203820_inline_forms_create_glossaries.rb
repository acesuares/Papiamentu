class InlineFormsCreateGlossaries < ActiveRecord::Migration[5.0]

  def self.up
    create_table :glossaries do |t|
      t.string :name
      t.string :title
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :glossaries
  end
end
