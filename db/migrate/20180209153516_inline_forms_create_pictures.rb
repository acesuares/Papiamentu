class InlineFormsCreatePictures < ActiveRecord::Migration[5.0]

  def self.up
    create_table :pictures do |t|
      t.string :name 
      t.string :caption 
      t.string :image 
      t.text :description 
      t.belongs_to :word 
      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end

end
