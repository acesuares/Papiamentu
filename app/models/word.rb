# -*- encoding : utf-8 -*-
class Word < ApplicationRecord
  before_create :add_variant
  acts_as_voteable
  acts_as_commontable
  attr_reader :per_page
  @per_page = 7
  attr_writer :inline_forms_attribute_list
  has_paper_trail

  default_scope { order(:name) }

  has_and_belongs_to_many :wordtypes
  has_and_belongs_to_many :goals
  has_and_belongs_to_many :sources
  has_and_belongs_to_many :fshp_categories
  has_and_belongs_to_many :glossaries
  has_and_belongs_to_many :spelling_groups
  has_many :variants
  has_many :pictures
  has_many :recordings
  has_many :spelling_tries
  belongs_to :user
  belongs_to :deleter, foreign_key: :deleted_by, class_name: 'User'

  IMMUTABLE = %w{buki_di_oro}

  validate :force_immutable
  validates :name, :presence => true
  validates :name, :uniqueness => true, on: :create

  scope :buki_di_oro, -> {where(buki_di_oro: 1)}
  scope :picture_ready, -> { joins(:pictures).where.not(pictures: {id: nil }) }
  scope :recording_ready, -> { joins(:recordings).where.not(recordings: {id: nil }) }

  enum buki_di_oro: { not_approved: 0, approved: 1 }
  enum attested: { not_standarized: 0, standarized: 1 }
  enum deleted: { active: 1, deleted: 2 }

  def _presentation
    ago = " (#{ActionController::Base.helpers.time_ago_in_words(created_at)} ago)" rescue ""
    wordtype = " (#{wordtypes.map(&:name).to_sentence})" rescue ''
    "#{name}#{wordtype}#{ago} #{'DELETED' if deleted?}"
  end

  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :header_lema, '', :header ],
      [ :name , "name", :text_field ],
      [ :deleted , "name", :info, DELETED ],
      [ :deleter , "name", :info ],
      [ :synonym , "synonym", :text_area_without_ckeditor ],
      [ :variants , "variants", :associated ],
      [ :header_gramma, '', :header ],
      [ :wordtypes, '', :check_list ],
      [ :countable , "countable", :radio_button, { 0 => 'nò', 1 => 'si', 2 => 'unknown' } ],
      [ :specific , "specific", :radio_button, { 0 => 'nò', 1 => 'si' } ],
      [ :school_language , "school_language", :radio_button, { 0 => 'nò', 1 => 'si' } ],
      [ :attested , "attested", :radio_button, { 'not_standarized' => 'nò', 'standarized' => 'si' } ],
      [ :attested_on , "attested_on", :date_select ],
      [ :user, '', :info ],
      [ :created_at, '', :info ],
      [ :header_fuente, '', :header ],
      [ :fshp_categories, '', :check_list ],
      [ :sources, '', :check_list ],
      [ :goals, '', :check_list ],
      [ :buki_di_oro, '', :info ], #radio_button, { 0 => 'nò', 1 => 'Buki di Oro 2009' } ],
      [ :header_splikashon, '', :header ],
      [ :description_nl , "description_nl", :text_area_without_ckeditor ],
      [ :description_pap_cw , "description_pap_cw", :text_area_without_ckeditor ],
      [ :tr_nl , "tr_nl", :text_field ],
      [ :tr_en , "tr_en", :text_field ],
      [ :tr_es , "tr_es", :text_field ],
      [ :tr_pap_cw , "tr_pap_cw", :text_field ],
      [ :tr_pap_aw , "tr_pap_aw", :text_field ],
      [ :buki_di_oro_text, '', :info ],
      [ :pictures , "pictures", :associated ],
      [ :recordings , "recordings", :associated ],
      [ :header_glosario, '', :header ],
      [ :glossaries, '', :check_list ],
      [ :header_spel_spel_group, '', :header ],
      [ :spelling_groups, '', :check_list ],
    ]
  end

  def yandex_translations
    translator = Yandex::Translator.new(ENV["YANDEX_TRANSLATE_KEY"])
    Hash[['en','nl','es'].map{|language|[language, translator.translate(self.name, from: 'pap', to: language)]}]
  end

  def is_money?
    is_money == 2
  end

  def monetary_value_nice
    monetary_value_in_mct / 10 < 100 ? "#{self.monetary_value_in_mct/10} sèn" : "#{self.monetary_value_in_mct/1000} florín" 
  end


  def self.not_accessible_through_html?
    false
  end

  def self.order_by_clause
    nil
  end


# stuff specific to frontends

  def word_max_length(max_length)
    self.name.length > max_length ?  self.name[0..max_length-1] + "..." : self.name
  end

  # Compare two Word object by comparing their name attribute
  def <=>(other)
    self.name <=> other.name
  end

  def previous_words(n=1)
    Word.unscoped.limit(n).order("name DESC").where("name < ?", name)
  end

  def next_words(n=1)
    Word.unscoped.limit(n).order("name ASC").where("name > ?", name)
  end

  def self.random
    Word.unscoped.where(buki_di_oro: 1).order('rand()').limit(1).first
  end

  def description_pap_cw_nice
    if description_pap_cw.blank?
      'deskripshon: e palabra aki no tin deskripshon na papiamentu ahinda'
    else
      "deskripshon: #{description_pap_cw}"
    end
  end

  def variants_nice
    "Variante ortográfiko: #{variants.map(&:_presentation).join(', ')}"
  end

  def countable?
    countable > 0
  end

  def specific?
    specific > 0
  end

  def varies?
    variants.count > 1
  end

  def self.find_by_variant(search_variant)
    Word.joins(:variants).where(variants: { lemma: search_variant }).first
  end

  # see http://stackoverflow.com/questions/861448/is-there-a-way-to-avoid-automatically-updating-rails-timestamp-fields
  def increment_views
    update_column(:views, self.views + 1)
  end

  # class methods
  def self.most_viewed(limit = 5, offset = 0)
    Word.unscoped.limit(limit).offset(offset).order('views DESC, name ASC')
  end

  def self.recently_updated(limit = 15, offset = 0)
    Word.unscoped.limit(limit).offset(offset).order('updated_at DESC, name ASC')
  end

  def self.mail_daily_new_words
    DailyNewWordsEmailWorker.perform_async
  end

  def self.mail_daily_own_words
    DailyOwnWordsEmailWorker.perform_async
  end

  def self.mail_weekly_new_words
    WeeklyNewWordsEmailWorker.perform_async
  end

  def self.mail_weekly_own_words
    WeeklyOwnWordsEmailWorker.perform_async
  end

  def self.mail_monthly_new_words
    MonthlyNewWordsEmailWorker.perform_async
  end

  def self.mail_monthly_own_words
    MonthlyOwnWordsEmailWorker.perform_async
  end


  # these three are needed for soft delete. And a migration of course.
  def self.safe_deletable?
    true
  end

  def safe_delete(current_user)
    self.deleted = 2
    self.deleter = current_user
    self.save
  end

  def safe_restore
    self.deleted = 1
    self.deleted_by = nil
    self.save
  end

  protected
    def add_variant
      variants << Variant.create(lemma: name, orthographic_type: 'cw')
    end

  private

  def force_immutable
    if self.persisted?
      IMMUTABLE.each do |attr|
        self.changed.include?(attr) &&
          errors.add(attr, :immutable) &&
          self[attr] = self.changed_attributes[attr]
      end
    end
  end
end
