class Variant < ActiveRecord::Base
  attr_reader :per_page
  @per_page = 7
  attr_writer :inline_forms_attribute_list
  has_paper_trail

  belongs_to :word

  def _presentation
    "#{orthographic_type}: #{lemma}"
  end


  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :lemma , "lemma", :text_field ],
      [ :orthographic_type , "orthographic_type", :text_field ],
    ]
  end


  def self.not_accessible_through_html?
    true
  end

  def self.order_by_clause
    "lemma"
  end


end
