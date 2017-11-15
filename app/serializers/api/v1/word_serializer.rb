class Api::V1::WordSerializer < ActiveModel::Serializer
  attributes(*Word.attribute_names.map(&:to_sym))
  self.root = false
  
  has_many :variants
end
