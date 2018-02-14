class SpellingTry < ApplicationRecord
  belongs_to :spelling_session
  belongs_to :word
end
