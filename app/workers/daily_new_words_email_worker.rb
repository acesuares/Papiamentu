class DailyNewWordsEmailWorker
  include Sidekiq::Worker
  def perform
    # email words that are created since yesterday
    User.active.new_words_daily.each do |user|
      words = Word.where("created_at > '%s'", Date.yesterday).limit(100)
      WordMailer.daily_new_words_email(user, words).deliver unless words.empty?
    end
  end
end
