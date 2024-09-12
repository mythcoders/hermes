class Ban::LogJob < ApplicationJob
  def perform(email, reason)
    Ban.log_now(email, reason)
  end
end
