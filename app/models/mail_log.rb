# frozen_string_literal: true

class MailLog < ApplicationRecord
  belongs_to :client
  validates_presence_of :to, :subject, :client, :environment

  def self.build(params)
    mail_log = MailLog.new(
      to: params[:to].join(', '),
      from: params[:from],
      subject: params[:subject],
      body: params[:body],
      content_type: params[:content_type],
      was_rerouted: params[:was_rerouted],
      environment: params[:environment],
      client: params[:client]
    )

    mail_log.cc = params[:cc].join(', ') if params[:cc].present?
    mail_log.bcc = params[:bcc].join(', ') if params[:bcc].present?
    mail_log
  end

  def html?
    content_type == 'html'
  end

  def text?
    content_type == 'text'
  end
end
