class SlideGamesController < InlineFormsController
  set_tab :slide_game
  layout 'frontends'
  autocomplete :word, :name, full: true, :scopes => [:has_pictures]

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

  def edit_game
    @slide_game = referenced_object
    redirect_to '/' if @slide_game.nil?
    word_to_add = Word.find_by_name(params[:add_word])
    @slide_game.words << word_to_add if word_to_add
    remove_words = params[:remove_words]
    unless remove_words.blank?
      words_to_remove = remove_words.map{ |word| Word.find_by_name(word) }.compact.uniq
      @slide_game.words.delete words_to_remove
    end
  end

  def play_game
    @slide_game = referenced_object
    authorize!(:play_game, SlideGame)
    render layout: 'slide_game'
  end

end
