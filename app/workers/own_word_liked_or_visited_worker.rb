class OwnWordLikedOrVisitedWorker
  include Sidekiq::Worker
  def perform(word_id, status)
    word = Word.find(word_id)
    user = word.user
    if user.active? && user.own_words_immediately?
      WordMailer.own_word_liked_or_visited_email(word, user, status).deliver
    end
  end
end
