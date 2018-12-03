class ApplicationMailer < ActionMailer::Base
  DEFAULT_FROM = 'Hermes <hermes@mythcoders.com>'
  default from: DEFAULT_FROM
  layout 'mailer'
end
