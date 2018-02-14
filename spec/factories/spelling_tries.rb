FactoryBot.define do
  factory :spelling_try do
    user_input "MyString"
    correct false
    spelling_session nil
  end
end
