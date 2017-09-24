class InlineFormsCreateWords < ActiveRecord::Migration

  def self.up
    create_table :words, :id => true do |t|
      t.string :name 
      t.text :synonym 
      t.belongs_to :source, :default => 1
      t.integer :attested, :default => 0 
      t.date :attested_on 
      t.integer :countable, :default => 0 
      t.integer :specific, :default => 0 
      t.integer :school_language, :default => 0
      t.text :description_nl 
      t.text :description_pap_cw 
      t.string :tr_nl 
      t.string :tr_en 
      t.string :tr_es 
      t.string :tr_pap_cw 
      t.string :tr_pap_aw 
      t.timestamps
    end
  end

  def self.down
    drop_table :words
  end

end
