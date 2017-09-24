class InlineFormsTranslation < ActiveRecord::Base
  attr_reader :per_page
  @per_page = 7
  attr_writer :inline_forms_attribute_list
  has_paper_trail

  belongs_to :inline_forms_key
  belongs_to :inline_forms_locale

  def _presentation
    "#{value}"
  end


  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :inline_forms_locale , "inline_forms_locale", :dropdown ], 
      [ :value , "value", :text_area ], 
      [ :interpolations , "interpolations", :text_area ], 
      [ :is_proc , "is_proc", :check_box ], 
    ]
  end


  def self.not_accessible_through_html?
    true
  end

  def self.order_by_clause
    "name"
  end


end
