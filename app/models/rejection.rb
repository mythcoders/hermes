class Rejection < ApplicationRecord
  include Actionable

  nillify_blanks :reason
end
