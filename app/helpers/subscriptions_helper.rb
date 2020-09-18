# frozen_string_literal: true

module SubscriptionsHelper
  def subscription_statuses
    Subscription.statuses.to_a.map do |t|
      OpenStruct.new(label: Subscription.human_enum_name(:status, t[0]), value: t[1])
    end
  end
end
