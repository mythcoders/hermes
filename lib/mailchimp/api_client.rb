# frozen_string_literal: true

module Mailchimp
  class ApiClient
    def self.html_to_text(html)
      Faraday.post("https://templates.mailchimp.com/services/html-to-text/") do |req|
        req.headers["Content-Type"] = "application/x-www-form-urlencoded; charset=utf-8"
        req.body = {"html" => html}
      end
    rescue => e
      Sentry.capture_exception e
    end
  end
end
