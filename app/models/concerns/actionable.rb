module Actionable
  extend ActiveSupport::Concern

  included do
    has_one :activity, as: :actionable, touch: true
  end
end
