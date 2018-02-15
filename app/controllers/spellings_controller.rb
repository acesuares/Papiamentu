class SpellingsController < ApplicationController
  layout 'application'
  include CancanConcern
  #load_and_authorize_resource :class => false

  def index
    authorize!(:index, :spellings)
    @spelling_groups = SpellingGroup.all
    @leaderboard = User.leaderboard.limit(10)
  end

  def play
    authorize!(:play, :spellings)
    @spelling_group = SpellingGroup.find_by_id params[:spelling_group]
    words = words_for_training_session params[:spelling_group]
    create_words_session_var words
    initialize_spelling_tries
    @word = next_word_from words
    @spelling_session = current_user.spelling_sessions.create
  end

  def check
    authorize!(:check, :spellings)

    next_word = ''
    word = Word.find params[:id]
    word_spelling = word.name.strip
    answer = params[:answer]

    if answer == word_spelling
      check = 'good'
      delete_from_words_session_var word.id
      tries = initialize_spelling_tries
      next_word = next_word_from words_in_session_var
    else
      tries = update_spelling_tries
    end

    word_spelling = word_spelling.chars.join '-'
    create_spelling_try params[:session_id], answer, check, word

    if tries > 2
      initialize_spelling_tries
      next_word = next_word_from words_in_session_var
    end

    respond_to do |format|
      format.html # contact.html.erb
      format.json {
        render json: {check: check,
          answer: answer,
          next_word: next_word,
          tries: tries,
          word_spelling: word_spelling
        }
      }
    end
  end

  def siguiente
    delete_from_words_session_var params[:id].to_i unless params[:id].empty?
    next_word = next_word_from words_in_session_var

    respond_to do |format|
      format.html # contact.html.erb
      format.json {
        render json: { next_word: next_word }
      }
    end
  end

  def session_results
    authorize!(:session_results, :spellings)
    @SpellingSession = SpellingSession.find(params[:session_id])
    @points = @SpellingSession.spelling_tries.sum(:points)
  end

  private

  def next_word_from words
    word = Word.find_by_id words.sample
    return '' if word.nil?
    hash_from_word word
  end

  def hash_from_word word
    {
      id: word.id,
      picture: word.pictures.sample.image.url,
      recording: word.recordings.sample.audio.url
    }
  end

  def words_for_training_session spelling_group_id = nil
    if spelling_group_id.nil?
      Word.picture_ready.recording_ready.limit(10).pluck(:id)
    else
      spelling_group = SpellingGroup.find(spelling_group_id)
      spelling_group.words.picture_ready.recording_ready.limit(10).pluck(:id)
    end
  end

  def create_words_session_var words
    session[:training_session_words] = words
  end

  def delete_from_words_session_var word_id
    session[:training_session_words].delete(word_id)
  end

  def words_in_session_var
    session[:training_session_words]
  end

  def initialize_spelling_tries
    session[:spelling_tries] = 1
  end

  def update_spelling_tries
     initialize_spelling_tries and return if session[:spelling_tries].nil?
    session[:spelling_tries] += 1
  end

  def create_spelling_try session_id, answer, check, word
    spelling_session = SpellingSession.find(session_id)
    session_try = spelling_session.spelling_tries.build
    session_try.user_input = answer
    session_try.word_id = word.id
    session_try.correct = check == 'good' ? true : false
    session_try.points = check == 'good' ? 5 : -1
    session_try.save
  end
end
