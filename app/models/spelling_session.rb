class SpellingSession < ApplicationRecord
  belongs_to :user
  has_many :spelling_tries
end
