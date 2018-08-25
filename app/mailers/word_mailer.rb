class WordMailer < ApplicationMailer
  include ActionView::Helpers::DateHelper

  # immediately

  def new_word_created_email(word_id, email)
    @word = Word.find(word_id)
    mail  to: email, subject: default_i18n_subject(word: @word.name)
  end

  def own_word_liked_or_visited_email(word, user, status)
    @word = word
    @user = user
    @status = status
    mail  to: user.email, subject: default_i18n_subject(word: @word.name)
  end

  # daily

  def daily_new_words_email(user, words)
    @words = words
    @user = user
    mail  to: user.email, subject: default_i18n_subject(count: @words.length, word: @words.first.name)
  end

  def daily_own_words_email(user, words)
    @words = words
    @user = user
    mail  to: user.email, subject: "Papiamentu: Visits and Likes for Today!"
  end

  # weekly

  def weekly_new_words_email(user, words)
    @words = words
    @user = user
    mail  to: user.email, subject: "Papiamentu: #{@words.length} New Words Created This Week!"
  end

  def weekly_own_words_email(user, words)
    @words = words
    @user = user
    mail  to: user.email, subject: "Papiamentu: Visits and Likes for This Week!"
  end

  # monthly

  def monthly_new_words_email(user, words)
    @words = words
    @user = user
    mail  to: user.email, subject: "Papiamentu: #{@words.length} New Words Created This Month!"
  end

  def monthly_own_words_email(user, words)
    @words = words
    @user = user
    mail  to: user.email, subject: "Papiamentu: Visits and Likes for This Month!"
  end

end
