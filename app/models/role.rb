class Role < ActiveRecord::Base
  attr_reader :per_page
  @per_page = 7
  attr_writer :inline_forms_attribute_list
  has_paper_trail

  validates :name, :presence => true, :uniqueness => true, :length => { :minimum => 3, :maximum => 254 }

  has_and_belongs_to_many :users

  default_scope order('name DESC')


  def _presentation
    "#{name}"
  end


  def inline_forms_attribute_list
    @inline_forms_attribute_list ||= [
      [ :name, '', :text_field ],
      [ :description, '', :text_area_without_ckeditor ],
      [ :users, '', :check_list ],
    ]
  end


  def self.not_accessible_through_html?
    false
  end

  def self.order_by_clause
    nil
  end


end
