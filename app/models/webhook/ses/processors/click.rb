class Webhook::SES::Processors::Click < Webhook::SES::Processors::Base
  def process
    recipient.clicked_at = timestamp if recipient.clicked_at.blank?
    recipient.activities.build(
      actioned_at: timestamp,
      actionable: Click.new(
        url: link,
        ip_address: ip_address,
        user_agent: user_agent
      )
    )
    recipient.save!
  end

  private

  def timestamp
    @timestamp ||= Time.iso8601 notification.message["click"]["timestamp"]
  end

  def user_agent
    @user_agent ||= notification.message["click"]["userAgent"]
  end

  def ip_address
    @ip_address ||= notification.message["click"]["ipAddress"]
  end

  def link
    @link ||= notification.message["click"]["link"]
  end
end
