class WeeklyOwnWordsEmailWorker
  include Sidekiq::Worker
  def perform
    # email votes casted for your own words since last week
    User.active.own_words_weekly.each do |user|
      words = user.words.select{|word| word.votes.where("'#{1.week.ago.to_date.to_s(:db)}' < created_at").length > 0}
      WordMailer.weekly_own_words_email(user, words).deliver unless words.empty?
    end
  end
end
