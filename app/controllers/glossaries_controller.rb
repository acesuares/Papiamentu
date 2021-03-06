class GlossariesController < InlineFormsController
  set_tab :glossary
  autocomplete :word, :name, full: true

  def show_glossary
    @glossary = referenced_object
    redirect_to '/' if @glossary.nil?

    respond_to do |format|
      format.html {
        render layout: 'frontends'
      }
    end
  end

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

  def edit_glossary
    @glossary = referenced_object
    redirect_to '/' if @glossary.nil?
    word_to_add = Word.find_by_name(params[:add_word])
    @glossary.words << word_to_add if word_to_add
    remove_words = params[:remove_words]
    unless remove_words.blank?
      words_to_remove = remove_words.map{ |word| Word.find_by_name(word) }.compact.uniq
      @glossary.words.delete words_to_remove
    end
    render layout: 'frontends'
  end

end
