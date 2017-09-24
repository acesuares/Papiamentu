class InlineFormsCreateInlineFormsLocales < ActiveRecord::Migration

  def self.up
    create_table :inline_forms_locales, :id => true do |t|
      t.string :name 
      t.belongs_to :inline_forms_translations 
      t.timestamps
    end
  end

  def self.down
    drop_table :inline_forms_locales
  end

end
