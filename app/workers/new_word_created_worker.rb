class NewWordCreatedWorker
  include Sidekiq::Worker
  def perform(word_id)
    User.active.new_words_immediately.each do |user|
      WordMailer.new_word_created_email(word_id, user.email).deliver
    end
  end
end
