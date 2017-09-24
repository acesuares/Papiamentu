# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 1.days do
   runner "Word.mail_daily_new_words"
   runner "Word.mail_daily_own_words"
end

every 1.weeks do
   runner "Word.mail_weekly_new_words"
   runner "Word.mail_weekly_own_words"
end

every 1.months do
   runner "Word.mail_monthly_new_words"
   runner "Word.mail_monthly_own_words"
end

every 1.minutes do
end
