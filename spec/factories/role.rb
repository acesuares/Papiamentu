FactoryGirl.define do
  factory :superadmin_role, class: Role do
    name 'superadmin'
    description 'Super Admin can access all.'
  end

  factory :viewer_role, class: Role do
    name 'viewer'
    description 'Viewer role.'
  end
end
