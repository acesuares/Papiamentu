class InlineFormsCreateWordtypes < ActiveRecord::Migration

  def self.up
    create_table :wordtypes, :id => true do |t|
      t.string :name 
      t.string :title_nl 
      t.string :title_en 
      t.string :title_es 
      t.string :title_pap 
      t.text :comment 
      t.timestamps
    end
  end

  def self.down
    drop_table :wordtypes
  end

end
