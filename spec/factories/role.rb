FactoryBot.define do
  factory :superadmin_role, class: Role do
    name 'superadmin'
    description 'Super Admin can access all.'
  end

  factory :admin_role, class: Role do
    name 'admin'
    description 'Admin role.'
  end

  factory :worker_role, class: Role do
    name 'worker'
    description 'Worker role.'
  end

  factory :viewer_role, class: Role do
    name 'viewer'
    description 'Viewer role.'
  end
end
