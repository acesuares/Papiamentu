class RolesController < InlineFormsController
  set_tab :role
  autocomplete :role, :name, full: true
end
