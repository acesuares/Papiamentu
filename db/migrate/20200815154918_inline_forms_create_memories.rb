class InlineFormsCreateMemories < ActiveRecord::Migration[5.0]

  def self.up
    create_table :memories do |t|
      t.string :name 
      t.timestamps
    end
  end

  def self.down
    drop_table :memories
  end

end
