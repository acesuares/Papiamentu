class Glossary < ApplicationRecord
  attr_reader :per_page
  @per_page = 7
  attr_writer :inline_forms_attribute_list
  has_paper_trail

  has_and_belongs_to_many :words
  belongs_to :user

  def _presentation
    name
  end


  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :user , "name", :info ],
      [ :name , "name", :text_field ],
      [ :title , "title", :text_field ],
      [ :description , "description", :text_area ],
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
