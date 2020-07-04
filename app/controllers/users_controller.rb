class UsersController < InlineFormsController
  set_tab :user
  autocomplete :user, :name, full: true, limit: 30
end
