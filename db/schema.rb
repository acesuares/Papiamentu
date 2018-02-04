# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180116154757) do

  create_table "commontator_comments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "creator_type"
    t.integer "creator_id"
    t.string "editor_type"
    t.integer "editor_id"
    t.integer "thread_id", null: false
    t.text "body", null: false
    t.datetime "deleted_at"
    t.integer "cached_votes_up", default: 0
    t.integer "cached_votes_down", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cached_votes_down"], name: "index_commontator_comments_on_cached_votes_down"
    t.index ["cached_votes_up"], name: "index_commontator_comments_on_cached_votes_up"
    t.index ["creator_id", "creator_type", "thread_id"], name: "index_commontator_comments_on_c_id_and_c_type_and_t_id"
    t.index ["thread_id", "created_at"], name: "index_commontator_comments_on_thread_id_and_created_at"
  end

  create_table "commontator_subscriptions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "subscriber_type", null: false
    t.integer "subscriber_id", null: false
    t.integer "thread_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscriber_id", "subscriber_type", "thread_id"], name: "index_commontator_subscriptions_on_s_id_and_s_type_and_t_id", unique: true
    t.index ["thread_id"], name: "index_commontator_subscriptions_on_thread_id"
  end

  create_table "commontator_threads", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "commontable_type"
    t.integer "commontable_id"
    t.datetime "closed_at"
    t.string "closer_type"
    t.integer "closer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commontable_id", "commontable_type"], name: "index_commontator_threads_on_c_id_and_c_type", unique: true
  end

  create_table "fshp_categories", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fshp_categories_words", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "fshp_category_id"
    t.integer "word_id"
  end

  create_table "goals", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "name"
    t.string "title_nl"
    t.string "title_en"
    t.string "title_es"
    t.string "title_pap"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goals_words", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "goal_id"
    t.integer "word_id"
  end

  create_table "inline_forms_keys", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inline_forms_locales", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "name"
    t.integer "inline_forms_translations_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inline_forms_translations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "inline_forms_key_id"
    t.integer "inline_forms_locale_id"
    t.text "value"
    t.text "interpolations"
    t.boolean "is_proc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sources", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "name"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sources_words", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "source_id"
    t.integer "word_id"
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.string "locale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer "new_words", default: 0
    t.integer "active", default: 1
    t.integer "own_words", default: 0
    t.integer "most_voted", default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "variants", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "lemma"
    t.string "orthographic_type"
    t.integer "word_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "votes", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.boolean "vote", default: false, null: false
    t.integer "voteable_id", null: false
    t.string "voteable_type", null: false
    t.integer "voter_id"
    t.string "voter_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["voteable_id", "voteable_type"], name: "index_votes_on_voteable_id_and_voteable_type"
    t.index ["voter_id", "voter_type", "voteable_id", "voteable_type"], name: "fk_one_vote_per_user_per_entity", unique: true
    t.index ["voter_id", "voter_type"], name: "index_votes_on_voter_id_and_voter_type"
  end

  create_table "words", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "name"
    t.text "synonym"
    t.integer "source_id", default: 1
    t.integer "attested", default: 0
    t.date "attested_on"
    t.integer "countable", default: 0
    t.integer "specific", default: 0
    t.integer "school_language", default: 0
    t.text "description_nl"
    t.text "description_pap_cw"
    t.string "tr_nl"
    t.string "tr_en"
    t.string "tr_es"
    t.string "tr_pap_cw"
    t.string "tr_pap_aw"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", default: 2
    t.integer "buki_di_oro", default: 0
    t.string "buki_di_oro_text"
    t.integer "views", default: 0
    t.integer "deleted", default: 1
    t.integer "deleted_by"
    t.index ["views"], name: "index_words_on_views"
  end

  create_table "words_wordtypes", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "word_id"
    t.integer "wordtype_id"
  end

  create_table "wordtypes", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "name"
    t.string "title_nl"
    t.string "title_en"
    t.string "title_es"
    t.string "title_pap"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
