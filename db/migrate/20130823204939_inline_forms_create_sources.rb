class InlineFormsCreateSources < ActiveRecord::Migration

  def self.up
    create_table :sources, :id => true do |t|
      t.string :name 
      t.text :comment 
      t.timestamps
    end
  end

  def self.down
    drop_table :sources
  end

end
