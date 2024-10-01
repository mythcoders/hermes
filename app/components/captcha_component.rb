class CaptchaComponent < ApplicationComponent
  def initialize(css_class: "", theme: "light")
    @css_classes = "h-captcha #{css_class}".strip
    @theme = theme
    @site_key = Rails.application.credentials.dig(:hcaptcha, :site_key)
  end

  def render?
    !Rails.env.test?
  end
end
