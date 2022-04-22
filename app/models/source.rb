class Source < ApplicationRecord
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

  require 'csv'
  def to_csv
    headers = ["id (niet aankomen)", "lemma (niet aankomen)", "Cur/Bon spelling (eventueel verbeteren)", "Aruba spelling", "NL", "EN", "ES", "Cur/Bon beschrijving (optioneel)", "Aruba beschrijving (optioneel)", "NL beschrijving (optioneel)", "EN beschrijving (optioneel)", "ES beschrijving (optioneel)", "wetenschappelijke naam (niet aankomen)"]
    column_names = ["id", "name", "tr_pap_cw", "tr_pap_aw", "tr_nl", "tr_en", "tr_es", "description_pap_cw", "description_pap_aw", "description_nl", "description_en", "description_es", "scientific_name"]
    CSV.generate do |csv|
      csv << headers
      words.each do |word|
        csv << word.attributes.values_at(*column_names)
     end
    end
  end

  def self.not_accessible_through_html?
    false
  end

  def self.order_by_clause
    nil
  end


end
