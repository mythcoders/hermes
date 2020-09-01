# frozen_string_literal: true

class MessageFactory
  def self.build(params, recieve_time = DateTime.Now)
    message = Message.new(
      client: params[:client],
      from: "#{params[:sender_name]} <#{params[:sender_email]}>",
      subject: params[:subject],
      html_body: params[:html_body],
      text_body: params[:text_body],
      priority: params[:priority],
      environment: params[:environment],
      tracking_id: params[:tracking_id]
    )

    message.recipients << MessageRecipientFactory.build_from_array(params[:to])
    message.recipients << MessageRecipientFactory.build_from_array(params[:cc]) if params[:cc].present?
    message.recipients << MessageRecipientFactory.build_from_array(params[:bcc]) if params[:bcc].present?
    message.activities << MessageActivity.new(type: 'Received', time: recieve_time)
    message
  end
end
