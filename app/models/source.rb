class Source < ActiveRecord::Base
  attr_reader :per_page
  @per_page = 7
  attr_writer :inline_forms_attribute_list
  has_paper_trail

  has_and_belongs_to_many :words

  def _presentation
    "#{name}"
  end


  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :name , "name", :text_field ],
      [ :comment , "comment", :text_area ],
      [ :words, '', :info_list ]
    ]
  end


  def self.not_accessible_through_html?
    false
  end

  def self.order_by_clause
    nil
  end


end
