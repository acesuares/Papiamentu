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
    words = words_for_training_session params[:spelling_group]
    create_words_session_var words
    @word = next_word_from words
    @spelling_session = current_user.spelling_sessions.create
  end

  def check
    authorize!(:check, :spellings)

    next_word = nil
    word = Word.find params[:id]
    answer = params[:answer]

    if answer == word.name.strip
      check = 'good'
      delete_from_words_session_var word
      next_word = next_word_from words_in_session_var
    end

    create_spelling_try params[:session_id], answer, check, word

    respond_to do |format|
      format.html # contact.html.erb
      format.json {
        render json: {check: check, answer: answer, next_word: next_word }
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

  def delete_from_words_session_var word
    session[:training_session_words].delete(word.id)
  end

  def words_in_session_var
    session[:training_session_words]
  end

  def create_spelling_try session_id, answer, check, word
    spelling_session = SpellingSession.find(session_id)
    session_try = spelling_session.spelling_tries.build
    session_try.user_input = answer
    session_try.word_id = word.id
    session_try.correct = check == 'good' ? true : false
    session_try.points = check == 'good' ? 5 : -5
    session_try.save
  end
end
