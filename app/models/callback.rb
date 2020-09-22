# frozen_string_literal: true

class Callback < ApplicationRecord
  include AASM

  aasm column: :status do
    state :created, initial: true
    state :errored, :finished

    event :error do
      transitions from: %i[created], to: :errored
    end

    event :finish do
      transitions from: %i[created errored], to: :finished
    end
  end
end
