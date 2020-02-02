# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :client
  has_many :recipients, class_name: 'MessageRecipient'
  has_many :activities, class_name: 'MessageActivity'
  validates_presence_of :sender, :subject, :client, :environment, :tracking_id, :content_type
  validates_presence_of :recipients, validates_associated: :recipients

  def self.build(params, client)
    message = new(
      client: client,
      subject: params[:subject],
      body: params[:body],
      content_type: params[:content_type],
      priority: params[:priority],
      environment: params[:environment],
      tracking_id: SecureRandom.uuid
    )

    if params[:sender_name].present? && params[:sender_email].present?
      message.sender = "#{params[:sender_name]} <#{params[:sender_email]}>"
    elsif params[:sender_email].present?
      message.sender = params[:sender_email]
    end

    message.recipients << MessageRecipient.build_from_array(params[:to], :to) if params[:to].present?
    message.recipients << MessageRecipient.build_from_array(params[:cc], :cc) if params[:cc].present?
    message.recipients << MessageRecipient.build_from_array(params[:bcc], :bcc) if params[:bcc].present?
    message
  end

  def receieve!(timestamp = Time.zone.now)
    activities << MessageActivity.new(activity_type: :received, notification_timestamp: timestamp)
    save!
  end

  def schedule!(timestamp = Time.zone.now)
    activities << MessageActivity.new(activity_type: :scheduled, notification_timestamp: timestamp)
    save!
  end

  def reroute!(timestamp = Time.zone.now)
    activities << MessageActivity.new(activity_type: :rerouted, notification_timestamp: timestamp)
    save!
  end

  def deliver!(timestamp = Time.zone.now)
    activities << MessageActivity.new(activity_type: :deliver, notification_timestamp: timestamp)
    save!
  end

  def sent!(timestamp = Time.zone.now)
    activities << MessageActivity.new(activity_type: :sent, notification_timestamp: timestamp)
    save!
  end

  def html?
    content_type == 'html'
  end

  def text?
    content_type == 'text'
  end
end
