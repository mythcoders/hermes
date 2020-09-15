# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :client
  has_many :recipients, class_name: 'MessageRecipient'
  has_many :activities, class_name: 'MessageActivity'
  validates_presence_of :sender, :subject, :client, :environment, :tracking_id
  validates_presence_of :recipients, validates_associated: :recipients

  def self.build(params, client)
    message = new(
      client: client,
      sender: params[:sender],
      subject: params[:subject],
      html_body: params[:html_body],
      text_body: params[:text_body],
      priority: params[:priority],
      environment: params[:environment],
      tracking_id: SecureRandom.uuid
    )

    message.recipients << MessageRecipient.build_from_array(params[:to], :to) if params[:to].present?
    message.recipients << MessageRecipient.build_from_array(params[:cc], :cc) if params[:cc].present?
    message.recipients << MessageRecipient.build_from_array(params[:bcc], :bcc) if params[:bcc].present?
    message
  end

  ACTIVITY_TYPES.each do |type|
    define_method "#{type}?" do
      activities.where(activity_type: type).any?
    end

    define_method "#{type}!" do |timestamp = Time.zone.now|
      activities << MessageActivity.new(activity_type: type, notification_timestamp: timestamp)
      save!
    end
  end

  RECIPIENT_TYPES.each do |type|
    define_method type.to_s do
      recipients.where(recipient_type: type)
    end
  end

  def basic_activity
    activities.where.not(activity_type: %w[delivered clicked opened])
  end

  def delivery_activity
    activities.where(activity_type: %w[delivered opened])
  end

  def link_activity
    activities.where(activity_type: 'clicked')
  end

  def client_environment
    @client_environment ||= ClientEnvironment.find_or_create_by_env!(client, environment)
  end
end
