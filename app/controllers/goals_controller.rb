class GoalsController < InlineFormsController
  set_tab :goal
  autocomplete :goal, :name, full: true

end
