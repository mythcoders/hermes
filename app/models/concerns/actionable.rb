module Actionable
  extend ActiveSupport::Concern

  included do
    has_one :activity, as: :action, touch: true
  end
end
