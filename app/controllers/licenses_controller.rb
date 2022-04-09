class LicensesController < InlineFormsController
  set_tab :license
  autocomplete :license, :name, full: false, limit: 12
end
