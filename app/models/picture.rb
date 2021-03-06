class Picture < ApplicationRecord
  attr_reader :per_page
  @per_page = 7
  attr_writer :inline_forms_attribute_list
  has_paper_trail

  mount_uploader :image, ImageUploader

  belongs_to :word
  belongs_to :user

  def _presentation
    "#{name} #{ActionController::Base.helpers.image_tag(image.thumb.url)}".html_safe # FIXME
  end

  def title_license_attribution
    "#{word.name} ⓒ #{user.name}, #{LICENSE}"
  end

  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :name , "name", :text_field ],
      [ :caption , "caption", :text_field ],
      [ :image , "image", :image_field ],
      [ :description , "description", :text_area ],
    ]
  end


  def self.not_accessible_through_html?
    true
  end

  def self.order_by_clause
    nil
  end
end
