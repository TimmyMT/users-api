# for commit changes need insert command:
# whenever --update-crontab
# whenever --update-crontab --set environment=production
# whenever --update-crontab --set environment=development

every 1.minute do
  runner "InspectTokensJob.perform_now"
end

every 1.day, at: '4:00 am' do
  runner "DailyTokenCleanJob.perform_now"
end
