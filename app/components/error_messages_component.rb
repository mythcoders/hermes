class ErrorMessagesComponent < ApplicationComponent
  def initialize(*models)
    @errors = models.map { |o| o.errors.full_messages }.flatten
  end

  def render?
    @errors.any?
  end
end
