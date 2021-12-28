# -*- encoding : utf-8 -*-
class Word < ApplicationRecord
  include InlineForms::SoftDeletable
  enum deleted: { active: 1, deleted: 2 }

  store :yandex_translation_cache, accessors: [ YANDEX_LANGUAGES ], coder: JSON, prefix: :yandex
  before_create do
    self.tr_pap_cw = name if tr_pap_cw.blank?
    self.tr_pap_aw = name if tr_pap_aw.blank?
  end


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
  belongs_to :deleter, foreign_key: :deleted_by, class_name: 'User', optional: true

  IMMUTABLE = %w{buki_di_oro buki_di_oro_text}

  validate :force_immutable
  validates :name, :presence => true
  validates :name, :uniqueness => true, on: :create

  scope :buki_di_oro, -> {where(buki_di_oro: 1)}
  scope :has_pictures, -> { joins(:pictures).where.not(pictures: {id: nil }) }
  scope :has_recordings, -> { joins(:recordings).where.not(recordings: {id: nil }) }

  scope :is_flora, -> { where(is_flora: 2) }
  scope :is_fauna, -> { where(is_fauna: 2) }
  scope :is_music, -> { where(is_music: 2) }

  enum buki_di_oro: { not_approved: 0, approved: 1 }
  enum attested: { not_standarized: 0, standarized: 1 }

  def main_lemma_switched(domain)
    if Rails.env.development?
      if domain == 3001
        tr_pap_aw
      else
        tr_pap_cw
      end
    else
      if domain == 'bancodipalabra.com'
        tr_pap_aw
      else
        tr_pap_cw
      end
    end
  end

  def _presentation
    created_ago = " (#{ActionController::Base.helpers.time_ago_in_words(created_at)} pasá)" rescue ""
    # wordtype = " (#{wordtypes.map(&:name).to_sentence})" rescue ''
    deleted_ago = " (#{ActionController::Base.helpers.time_ago_in_words(deleted_at)} pasá)" rescue ""
    deleted_nice = deleted? ? "deleted by #{deleter.name} #{deleted_ago}" : ""
    "#{name} #{created_ago} #{deleted_nice}"
  end

  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :header_lema, '', :header ],
      [ :name , "name", :text_field ],
      [ :deleted , "name", :info, DELETED ],
      [ :deleter , "name", :info ],
      [ :synonym , "synonym", :text_area_without_ckeditor ],
      # [ :variants , "variants", :associated ],
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
      [ :context, "description_nl", :text_area_without_ckeditor ],
      [ :varianten, "description_nl", :text_field ],
      [ :description_nl , "description_nl", :text_area_without_ckeditor ],
      [ :description_pap_cw , "description_pap_cw", :text_area_without_ckeditor ],
      [ :comment , "description_nl", :text_area_without_ckeditor ],
      [ :tr_nl , "tr_nl", :text_field ],
      # [ :tr_nl_variant , "tr_nl", :text_field ],
      [ :tr_en , "tr_en", :text_field ],
      [ :tr_es , "tr_es", :text_field ],
      [ :tr_pap_cw , "tr_pap_cw", :text_field ],
      [ :tr_pap_aw , "tr_pap_aw", :text_field ],
      [ :symbool , "tr_nl", :info ],
      [ :atoomnummer , "tr_nl", :info ],
      [ :is_element , "tr_nl", :info ],
      [ :buki_di_oro_text, '', :info ],
      [ :pictures , "pictures", :associated ],
      [ :recordings , "recordings", :associated ],
      [ :header_glosario, '', :header ],
      [ :glossaries, '', :check_list ],
      [ :header_spel_spel_group, '', :header ],
      [ :spelling_groups, '', :check_list ],
    ]
  end

  def self.list_words_with_this_length(length)
    if length == 1
      []
    else
      buki_di_oro.where("LENGTH(name)=%s", length)
    end
  end

  def get_yandex_translations(force=false)
    ## get new yandex key!!! 2021-06-10
    # if yandex_translation_cache.empty?
    #   translator = Yandex::Translator.new(ENV["YANDEX_TRANSLATE_KEY"])
    #   YANDEX_LANGUAGES.each do |language|
    #     yandex_translation_cache[language] = translator.translate(self.name, from: 'pap', to: language)
    #   end
    #   save unless yandex_translation_cache.empty?
    # end
  end

  def is_money?
    is_money == 2
  end

  def is_fauna?
    is_fauna == 2
  end

  def is_flora?
    is_flora == 2
  end

  def is_element?
    is_element == 2
  end

  def has_pictures?
    ! pictures.empty?
  end

  def has_recordings?
    ! recordings.empty?
  end

  def monetary_value_nice
    monetary_value_in_mct / 10 < 100 ? "#{monetary_value_in_mct/10} sèn" : "#{monetary_value_in_mct/1000} florín"
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

  def self.random_from_buki_di_oro(quantity)
    # need unscoped if there's a default scope
    Word.unscoped.buki_di_oro.order('rand()').limit(quantity)
  end

  def self.random_with_pictures(quantity)
    Word.unscoped.has_pictures.order('rand()').limit(quantity)
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

  def image_from_word(attribute)
    # convert white.png -size 350x250 -background none caption:"barbulete kaya mino wau"  -pointsize 72 -gravity Center -composite result.png
    if [:tr_pap_cw].include? attribute
      value = send(attribute)
      background_image = "#{Rails.root}/app/assets/images/white.png"
      store_dir = "#{Rails.root}/public/uploads/word/#{attribute}/#{self.id}"
      FileUtils.mkdir_p(store_dir) unless Dir.exists?(store_dir)
      convert = MiniMagick::Tool::Convert.new
      convert << background_image
      convert << "-size"
      convert << "350x250"
      convert << "-background"
      convert << "none"
      convert << "-pointsize"
      convert << "72"
      convert << "-font"
      convert << "Roboto"
      convert << "-gravity"
      convert << "Center"
      convert << "caption:#{value}"
      convert << "-composite"
      convert << "#{store_dir}/#{value.squish.gsub(CHARACTER_REGEX,'')}.png"
      convert.call
    end
  end


  protected
    # variants << Variant.create(lemma: name, orthographic_type: 'cw')

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
