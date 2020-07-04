class SourcesController < InlineFormsController
  set_tab :source
  autocomplete :source, :name, full: true, limit: 30
end
