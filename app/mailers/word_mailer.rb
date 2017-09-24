class WordMailer < ApplicationMailer
  include ActionView::Helpers::DateHelper

  # immediately

  def new_word_created_email(word_id, email)
    @word = Word.find(word_id)
    mail  to: email, subject: "Papiamentu: A krea palabra nobo: #{@word.name}"
  end

  def own_word_liked_or_visited_email(word, user, status)
    @word = word
    @user = user
    @status = status
    if status == 2
      mail  to: user.email, subject: "Papiamentu: New Visit: #{word.name} (now #{word.views})"
    else
      mail  to: user.email, subject: "Papiamentu: New Vote: #{status} for #{word.name}"
    end
  end

  # daily

  def daily_new_words_email(user, words)
    @words = words
    @user = user
    mail  to: user.email, subject: "Papiamentu: #{@words.length} New Words Created Today!"
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
