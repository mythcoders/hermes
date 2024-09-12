require "test_helper"

class BanTest < ActiveSupport::TestCase
  test "registered?" do
    refute Ban.registered?("test@you.com")
    Ban.register "test@you.com", "spam"
    assert Ban.registered?("test@you.com")
  end

  test "register" do
    assert_difference "Ban.count" do
      Ban.register "test@you.com", "spam"
    end

    assert_no_difference "Ban.count" do
      Ban.register "test@you.com", "spam"
    end
  end
end
