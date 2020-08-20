class SlideGame < ApplicationRecord
  attr_reader :per_page
  @per_page = 7
  attr_writer :inline_forms_attribute_list
  has_paper_trail

  has_and_belongs_to_many :words
  belongs_to :user

  default_scope { order('name')}

  def _presentation
    name
  end

  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :user , "user", :info],
      [ :name , "name", :text_field ],
      [ :title , "name", :text_field ],
      [ :description, "name", :text_area ],
      [ :words, 'words_in_glossary', :info_list ],
    ]
  end


  def self.not_accessible_through_html?
    false
  end

  def self.order_by_clause
    nil
  end


end
