class AddYandexTranslationCacheToWord < ActiveRecord::Migration[5.2]
  def change
    add_column :words, :yandex_translation_cache, :text
  end
end
