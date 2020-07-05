class SourcesController < InlineFormsController
  set_tab :source
  autocomplete :source, :name, full: true
end
