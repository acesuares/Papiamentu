class MemoriesController < InlineFormsController
  set_tab :memory
  autocomplete :memory, :name, full: true

  def game
    authorize!(:game, Memory)
    render layout: 'frontends'
  end
end
