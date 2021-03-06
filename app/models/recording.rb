class Recording < ApplicationRecord
  attr_reader :per_page
  @per_page = 7
  attr_writer :inline_forms_attribute_list
  has_paper_trail

  mount_uploader :audio, AudioUploader

  belongs_to :word
  belongs_to :user

  def _presentation
    "#{name} #{ActionController::Base.helpers.audio_tag(audio.url, autoplay: false, controls: true)}".html_safe
  end


  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :name , "name", :text_field ],
      [ :audio , "audio", :audio_field ],
    ]
  end


  def self.not_accessible_through_html?
    true
  end

  def self.order_by_clause
    nil
  end
end
