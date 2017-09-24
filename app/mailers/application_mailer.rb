class ApplicationMailer < ActionMailer::Base
  default from: "ace@suares.com"
  layout false
  helper FrontendsHelper
end
