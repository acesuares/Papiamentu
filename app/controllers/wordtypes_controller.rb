class WordtypesController < InlineFormsController
  set_tab :wordtype
  autocomplete :wordtype, :name, full: true, limit: 30
end
