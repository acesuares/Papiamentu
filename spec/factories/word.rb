FactoryBot.define do
  factory :word do
    name 'palabra'


    after(:create) do |word|
      word.user = create(:user, :superadmin)
      word.save
    end
  end
end
