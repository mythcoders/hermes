require "test_helper"

class SenderTest < ActiveSupport::TestCase
  test "name is unique" do
    sender = Sender.new(name: senders(:one).name)
    refute sender.valid?
    assert_not_nil sender.errors.where(:name, :unique)
  end
end
