# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  ACTIVITY_TYPES = %i[received rerouted processed sent delivered failed error clicked held ignored].freeze
  RECIPIENT_TYPES = %i[to cc bcc].freeze

  def self.human_enum_name(enum_name, enum_value)
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{enum_value}")
  end
end
