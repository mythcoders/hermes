class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.nillify_blanks(*columns)
    normalizes(*columns, with: -> { _1.strip.presence })
  end

  def self.enum_display(name, value)
    return nil if value.blank?

    I18n.t(
      "activerecord.attributes.#{model_name.i18n_key}.#{name.to_s.pluralize}.#{value}",
      default: value.to_s.titleize
    )
  end
end
