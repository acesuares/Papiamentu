class WordtypesController < InlineFormsController
  set_tab :wordtype
  autocomplete :wordtype, :name, full: true
end
