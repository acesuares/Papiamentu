class DailyOwnWordsEmailWorker
  include Sidekiq::Worker
  def perform
    # email votes casted for your own words since yesterday
    User.active.own_words_daily.each do |user|
      words = user.words.select{|word| word.votes.where("created_at > '%s'", Date.yesterday).length > 0}
      WordMailer.daily_own_words_email(user, words).deliver unless words.empty?
    end
  end
end
