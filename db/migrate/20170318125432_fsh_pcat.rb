class FshPcat < ActiveRecord::Migration
  def up
    say_with_time "Restore fshp_categories..." do
      File.open("fshp.csv", "r").each_line do |line|
        line = line.strip
        word, cat = line.split ';'
        db_word = Word.where(name: word)
        if db_word.empty?
          say "#{word}; Not found", :subitem
        else
          db_word = db_word.first
          db_cat = FshpCategory.find(cat)
          if db_cat.nil?
            say "#{word}; Category #{cat} Not found", :subitem
          else
            db_word.fshp_categories << db_cat
            say "#{word}; #{db_cat.name}", :subitem
          end
          unless db_word.fshp_category_ids == db_word.fshp_category_ids.uniq
            cat_ids = db_word.fshp_category_ids.uniq
            db_word.fshp_categories.delete_all
            cat_ids.each do |cat_id|
              db_word.fshp_categories << FshpCategory.find(cat_id)
            end
          end
        end
        # line.encode!("utf-8", "utf-8", :invalid => :replace)
        # Sender.create({name: line}, without_protection: true) unless line.blank?
      end
    end

  end

  def down
  end
end
