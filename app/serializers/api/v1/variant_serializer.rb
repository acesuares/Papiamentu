class Api::V1::VariantSerializer < ActiveModel::Serializer
  attributes :id, :lemma, :orthographic_type
end
