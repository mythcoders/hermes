class Webhook::SES::Processors::Opened < Webhook::SES::Processors::Base
  def process
    ActiveRecord::Base.transaction do
      destination.opened_at = timestamp unless destination.opened?
      destination.activities.build(
        actioned_at: timestamp,
        actionable: Open.new(
          ip_address: ip_address,
          user_agent: user_agent
        )
      )
      destination.save!
    end

    true
  end

  private

  def timestamp
    @timestamp ||= Time.iso8601 notification.message["open"]["timestamp"]
  end

  def user_agent
    @user_agent ||= notification.message["open"]["userAgent"]
  end

  def ip_address
    @ip_address ||= notification.message["open"]["ipAddress"]
  end
end
