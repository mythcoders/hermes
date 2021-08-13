# frozen_string_literal: true

class PlainText
  def initialize(html_input)
    @html_input = html_input
  end

  def self.from_html(html_input)
    new(html_input).value
  end

  def value
    response = Mailchimp::ApiClient.html_to_text(@html_input)
    if response.success?
      response.body
    else
      parsed_from_nokogiri
    end
  end

  private

  def parsed_from_nokogiri
    body_parts = []
    Nokogiri::HTML(@html_input).traverse do |node|
      if node.text? && !(content = node.content ? node.content.strip : nil).blank?
        body_parts << content
      elsif node.name == "a" && (href = node.attr("href")) && href.match(/^https?:/)
        body_parts << href
      end
    end

    body_parts.uniq.join("\n")
  end
end
