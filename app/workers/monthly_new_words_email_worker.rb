class MonthlyNewWordsEmailWorker
  include Sidekiq::Worker
  def perform
    User.active.new_words_monthly.each do |user|
      # user_last_signed_in_at = user.last_sign_in_at.nil? ? "1970-01-01 00:00:00" : user.last_sign_in_at.to_s(:db)
      words = Word.where("'#{1.month.ago.to_date.to_s(:db)}' < created_at").limit(100)
      WordMailer.monthly_new_words_email(user, words).deliver unless words.empty?
    end
  end
end
