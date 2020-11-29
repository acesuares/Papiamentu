class MemoryGamesController < InlineFormsController
  set_tab :memory_game
  layout 'frontends'
  autocomplete :word, :name, full: false, limit: 12, scopes: [:has_pictures]

  def new
    @object = @Klass.new
    @object.user_id = current_user.id
    super
  end

  def create
    @object = @Klass.new
    @object.user_id = current_user.id
    super
  end

  def edit_memory_game
    @memory_game = referenced_object
    redirect_to '/' if @memory_game.nil?
    word_to_add = Word.find_by_name(params[:add_word])
    @memory_game.words << word_to_add if word_to_add
    remove_words = params[:remove_words]
    unless remove_words.blank?
      words_to_remove = remove_words.map{ |word| Word.find_by_name(word) }.compact.uniq
      @memory_game.words.delete words_to_remove
    end
    @memory_game.words = @memory_game.words.uniq
  end

  def play_memory_game
    authorize!(:play_memory_game, MemoryGame)
    @memory_game = referenced_object
    render layout: false
  end

  def play_random_memory_game
    authorize!(:play_random_memory_game, MemoryGame)
    render layout: false
  end

end
