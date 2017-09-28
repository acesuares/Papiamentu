# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20170925162735) do

  create_table "commontator_comments", :force => true do |t|
    t.string   "creator_type"
    t.integer  "creator_id"
    t.string   "editor_type"
    t.integer  "editor_id"
    t.integer  "thread_id",                        :null => false
    t.text     "body",                             :null => false
    t.datetime "deleted_at"
    t.integer  "cached_votes_up",   :default => 0
    t.integer  "cached_votes_down", :default => 0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "commontator_comments", ["cached_votes_down"], :name => "index_commontator_comments_on_cached_votes_down"
  add_index "commontator_comments", ["cached_votes_up"], :name => "index_commontator_comments_on_cached_votes_up"
  add_index "commontator_comments", ["creator_id", "creator_type", "thread_id"], :name => "index_commontator_comments_on_c_id_and_c_type_and_t_id"
  add_index "commontator_comments", ["thread_id", "created_at"], :name => "index_commontator_comments_on_thread_id_and_created_at"

  create_table "commontator_subscriptions", :force => true do |t|
    t.string   "subscriber_type", :null => false
    t.integer  "subscriber_id",   :null => false
    t.integer  "thread_id",       :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "commontator_subscriptions", ["subscriber_id", "subscriber_type", "thread_id"], :name => "index_commontator_subscriptions_on_s_id_and_s_type_and_t_id", :unique => true
  add_index "commontator_subscriptions", ["thread_id"], :name => "index_commontator_subscriptions_on_thread_id"

  create_table "commontator_threads", :force => true do |t|
    t.string   "commontable_type"
    t.integer  "commontable_id"
    t.datetime "closed_at"
    t.string   "closer_type"
    t.integer  "closer_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "commontator_threads", ["commontable_id", "commontable_type"], :name => "index_commontator_threads_on_c_id_and_c_type", :unique => true

  create_table "fshp_categories", :force => true do |t|
    t.string   "name"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fshp_categories_words", :id => false, :force => true do |t|
    t.integer "fshp_category_id"
    t.integer "word_id"
  end

  create_table "goals", :force => true do |t|
    t.string   "name"
    t.string   "title_nl"
    t.string   "title_en"
    t.string   "title_es"
    t.string   "title_pap"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "goals_words", :id => false, :force => true do |t|
    t.integer "goal_id"
    t.integer "word_id"
  end

  create_table "inline_forms_keys", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "inline_forms_locales", :force => true do |t|
    t.string   "name"
    t.integer  "inline_forms_translations_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "inline_forms_translations", :force => true do |t|
    t.integer  "inline_forms_key_id"
    t.integer  "inline_forms_locale_id"
    t.text     "value"
    t.text     "interpolations"
    t.boolean  "is_proc"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sources", :force => true do |t|
    t.string   "name"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sources_words", :id => false, :force => true do |t|
    t.integer "source_id"
    t.integer "word_id"
  end

  create_table "translations", :id => false, :force => true do |t|
    t.string  "locale"
    t.string  "thekey"
    t.text    "value"
    t.text    "interpolations"
    t.boolean "is_proc"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "locale"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "new_words",              :default => 0
    t.integer  "active",                 :default => 1
    t.integer  "own_words",              :default => 0
    t.integer  "most_voted",             :default => 0
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "variants", :force => true do |t|
    t.string   "lemma"
    t.string   "orthographic_type"
    t.integer  "word_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "votes", :force => true do |t|
    t.boolean  "vote",          :default => false, :null => false
    t.integer  "voteable_id",                      :null => false
    t.string   "voteable_type",                    :null => false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "votes", ["voteable_id", "voteable_type"], :name => "index_votes_on_voteable_id_and_voteable_type"
  add_index "votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], :name => "fk_one_vote_per_user_per_entity", :unique => true
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

  create_table "words", :force => true do |t|
    t.string   "name"
    t.text     "synonym"
    t.integer  "source_id",          :default => 1
    t.integer  "attested",           :default => 0
    t.date     "attested_on"
    t.integer  "countable",          :default => 0
    t.integer  "specific",           :default => 0
    t.integer  "school_language",    :default => 0
    t.text     "description_nl"
    t.text     "description_pap_cw"
    t.string   "tr_nl"
    t.string   "tr_en"
    t.string   "tr_es"
    t.string   "tr_pap_cw"
    t.string   "tr_pap_aw"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "user_id",            :default => 2
    t.integer  "buki_di_oro",        :default => 0
    t.string   "buki_di_oro_text"
    t.integer  "views",              :default => 0
    t.integer  "deleted",            :default => 1
    t.integer  "deleted_by"
  end

  add_index "words", ["views"], :name => "index_words_on_views"

  create_table "words_wordtypes", :id => false, :force => true do |t|
    t.integer "word_id"
    t.integer "wordtype_id"
  end

  create_table "wordtypes", :force => true do |t|
    t.string   "name"
    t.string   "title_nl"
    t.string   "title_en"
    t.string   "title_es"
    t.string   "title_pap"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
