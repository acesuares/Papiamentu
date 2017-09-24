class InlineFormsCreateViewForTranslations < ActiveRecord::Migration

  def self.up
    execute 'CREATE VIEW translations
             AS
               SELECT L.name AS locale,
                      K.name AS thekey,
                      T.value AS value,
                      T.interpolations AS interpolations,
                      T.is_proc AS is_proc
                 FROM inline_forms_keys K, inline_forms_locales L, inline_forms_translations T
                   WHERE T.inline_forms_key_id = K.id AND T.inline_forms_locale_id = L.id '
  end

  def self.down
    execute 'DROP VIEW translations'
  end

end
