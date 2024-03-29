# frozen_string_literal: true

module MessagesHelper
  def activity_icon(key)
    case key
    when "received"
      "satellite-dish"
    when "rerouted"
      "traffic-light"
    when "failed"
      "minus-octagon"
    when "complaint"
      "exclamation-triangle"
    when "error"
      "dumpster-fire"
    when "processed"
      "badge-check"
    when "held"
      "pause-circle"
    when "ignored"
      "ban"
    when "opened"
      "envelope-open"
    when "clicked"
      "link"
    else
      "info-circle"
    end
  end

  def activity_message(key)
    case key
    when "received"
      "API request recieved"
    when "rerouted"
      "Rerouted"
    when "processed"
      "Forwarded to AWS"
    when "opened"
      "Open"
    when "clicked"
      "Click"
    when "held"
      "On Hold"
    when "ignored"
      "Message Ignored"
    else
      key
    end
  end

  def activity_color(key)
    case key
    when "rerouted", "complaint", "held", "ignored"
      "secondary"
    when "failed", "error"
      "danger"
    else
      "default"
    end
  end

  def email_array_to_string(list)
    list.map(&:email).join(", ")
  end
end
