class MemoriesController < InlineFormsController
  set_tab :memory
  autocomplete :memory, :name, full: true

  def game
    authorize!(:game, :memories)
    render layout: 'memory_game'
  end
end
