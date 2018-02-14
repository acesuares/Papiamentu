class InlineFormsCreateSpellingGroups < ActiveRecord::Migration[5.0]

  def self.up
    create_table :spelling_groups do |t|
      t.string :name 
      t.string :caption 
      t.string :image 
      t.text :description 
      t.timestamps
    end
  end

  def self.down
    drop_table :spelling_groups
  end

end
