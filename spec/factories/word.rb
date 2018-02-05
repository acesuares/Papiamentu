FactoryBot.define do
  factory :word do
    name 'palabra'



    after(:create) do |word|
      if word.user.nil?
        word.user = create(:user, :superadmin)
        word.save
      end
    end
  end
end
