require "test_helper"

class BanTest < ActiveSupport::TestCase
  test "registered?" do
    refute Ban.registered?("test@you.com")
    Ban.log_now "test@you.com", "spam"
    assert Ban.registered?("test@you.com")
  end

  test "log_now" do
    assert_difference "Ban.count" do
      Ban.log_now "test@you.com", "spam"
    end

    assert_no_difference "Ban.count" do
      Ban.log_now "test@you.com", "spam"
    end
  end

  test "log_later" do
    assert_enqueued_with(job: Ban::LogJob) do
      Ban.log_later "test@you.com", "spam"
    end
  end
end
