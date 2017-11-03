class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def human_attribute_name(*args)
    self.class.human_attribute_name(*args)
  end  
end
