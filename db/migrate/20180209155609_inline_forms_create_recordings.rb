class InlineFormsCreateRecordings < ActiveRecord::Migration[5.0]

  def self.up
    create_table :recordings do |t|
      t.string :name 
      t.string :author 
      t.string :audio 
      t.belongs_to :word 
      t.timestamps
    end
  end

  def self.down
    drop_table :recordings
  end

end
