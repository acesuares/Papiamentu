class WeeklyNewWordsEmailWorker
  include Sidekiq::Worker
  def perform
    # email new words since last week
    User.active.new_words_weekly.each do |user|
      words = Word.where("'#{1.week.ago.to_date.to_s(:db)}' < created_at").limit(100)
      WordMailer.weekly_new_words_email(user, words).deliver unless words.empty?
    end
  end
end
