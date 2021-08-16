# frozen_string_literal: true

require "pathname"

module HermesApp
  class << self
    def root
      Pathname.new(File.expand_path("..", __dir__))
    end

    def env_name
      case Rails.env
      when "development"
        "DEV"
      when "test"
        Rails.env.case
      when "review"
        "REV"
      else
        "PROD"
      end
    end

    def branch
      value = Rails.root.join("BRANCH").read.chomp
      if value.include?("refs/")
        value.sub!(%r{refs/(heads/|tags/)}, "")
      else
        value
      end
    end

    def env_url(protocol: true)
      if ENV["GITLAB_ENVIRONMENT_URL"].present? && protocol
        ENV["GITLAB_ENVIRONMENT_URL"].gsub("HTTP", "HTTPS").gsub("http", "https")
      elsif ENV["GITLAB_ENVIRONMENT_URL"].present?
        ENV["GITLAB_ENVIRONMENT_URL"].split("//").last
      else
        "hermes.mythcoders.dev"
      end
    end
  end

  COMMIT = File.read(HermesApp.root.join("COMMIT")).strip.freeze
  VERSION = File.read(HermesApp.root.join("VERSION")).strip.freeze
end
