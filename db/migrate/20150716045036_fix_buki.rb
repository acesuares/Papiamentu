class FixBuki < ActiveRecord::Migration

  def up
    # two new fields
    add_column :words, :buki_di_oro, :integer, default: 0
    add_column :words, :buki_di_oro_text, :string
    Word.connection.schema_cache.clear!
    Word.reset_column_information

    # source = 13
    fpi_source = Source.find(13)

    # make a table for the wordtypes
    # (v = verbo; a = athetivo; s = sustantivo; b = atverbio; pre = preposishon; pro = pronomber; i = interhekshon; k = konhunshon; art = artikulo; n = numeral; x = nada)
    # +----+--------------+----------+----------+----------+-----------+---------+---------------------+---------------------+
    # | id | name         | title_nl | title_en | title_es | title_pap | comment | created_at          | updated_at          |
    # +----+--------------+----------+----------+----------+-----------+---------+---------------------+---------------------+
    # |  1 | athetivo     | NULL     | NULL     | NULL     | NULL      | NULL    | 2013-08-23 23:13:20 | 2013-08-23 23:13:20 |
    # |  2 | atverbio     | NULL     | NULL     | NULL     | NULL      | NULL    | 2013-08-23 23:13:20 | 2013-08-23 23:13:20 |
    # |  3 | interhekshon | NULL     | NULL     | NULL     | NULL      | NULL    | 2013-08-23 23:13:20 | 2013-08-23 23:13:20 |
    # |  5 | numeral      | NULL     | NULL     | NULL     | NULL      | NULL    | 2013-08-23 23:13:20 | 2013-08-28 14:20:09 |
    # |  6 | preposishon  | NULL     | NULL     | NULL     | NULL      | NULL    | 2013-08-23 23:13:20 | 2013-08-23 23:13:20 |
    # |  7 | pronòmber    | NULL     | NULL     | NULL     | NULL      | NULL    | 2013-08-23 23:13:20 | 2013-08-28 14:21:02 |
    # |  8 | sustantivo   | NULL     | NULL     | NULL     | NULL      | NULL    | 2013-08-23 23:13:20 | 2013-08-23 23:13:20 |
    # |  9 | verbo        | NULL     | NULL     | NULL     | NULL      | NULL    | 2013-08-23 23:13:20 | 2013-08-23 23:13:20 |
    # +----+--------------+----------+----------+----------+-----------+---------+---------------------+---------------------+
    translate_wordtypes = %w( x
                              a
                              b
                              i
                              unknown2
                              n
                              pre
                              pro
                              sus
                              v
                            )

    # get the words with attested=99 (those are the imported words)
    buki_words = Word.where(attested: 99)

    # execute 'INSERT INTO words (id, name, tr_pap_cw, tr_pap_aw, tr_nl, description_pap_cw, attested) VALUES ("","abandono","n","sus","","abandono (sus.)","99");'
    buki_words.each do |buki_word|
      # [ :countable , "countable", :radio_button, { 0 => 'nò', 1 => 'si', 2 => 'unknown' } ],
      buki_word.countable = 2
      buki_word.countable = 1 if buki_word.tr_pap_cw == 'y'
      buki_word.countable = 0 if buki_word.tr_pap_cw == 'n'
      buki_word.tr_pap_cw = nil
      # [ :wordtypes, '', :check_list ],
      wordtype_id = translate_wordtypes.index(buki_word.tr_pap_aw)
      unless wordtype_id.nil? || wordtype_id == 0
        buki_word.wordtypes = [Wordtype.find(wordtype_id)]
      end
      buki_word.tr_pap_aw = nil
      # junk from import
      buki_word.tr_nl = nil
      # tekst uit buki oro
      buki_word.buki_di_oro_text = buki_word.description_pap_cw
      buki_word.description_pap_cw = nil
      # attested = 99 means buki di oro
      buki_word.buki_di_oro = 1
      buki_word.attested = 0
      # user_id = 5 (FPI)
      buki_word.user_id = 5
      # source = 13
      buki_word.sources = [fpi_source]

      # save
      buki_word.save(validate: false)

    end

  end

  def down
  end

end
