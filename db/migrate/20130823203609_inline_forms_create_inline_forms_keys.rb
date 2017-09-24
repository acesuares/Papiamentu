class InlineFormsCreateInlineFormsKeys < ActiveRecord::Migration

  def self.up
    create_table :inline_forms_keys, :id => true do |t|
      t.string :name 
      t.timestamps
    end
  end

  def self.down
    drop_table :inline_forms_keys
  end

end
