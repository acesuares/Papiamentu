class InlineFormsCreateInlineFormsTranslations < ActiveRecord::Migration

  def self.up
    create_table :inline_forms_translations, :id => true do |t|
      t.belongs_to :inline_forms_key 
      t.belongs_to :inline_forms_locale 
      t.text :value 
      t.text :interpolations 
      t.boolean :is_proc 
      t.timestamps
    end
  end

  def self.down
    drop_table :inline_forms_translations
  end

end
