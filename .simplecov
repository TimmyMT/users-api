# frozen_string_literal: true

SimpleCov.start 'rails' do
  add_filter '/spec/'
  add_filter '/test/'
  add_filter '/swagger/'
  add_filter '/db/'
  add_filter '/app/controllers/main_controller.rb'
  add_filter '/app/jobs/application_job.rb'
  add_filter '/app/mailers/application_mailer.rb'

  SimpleCov.minimum_coverage 100
end