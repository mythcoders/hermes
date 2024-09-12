require "test_helper"

class ClientTest < ActiveSupport::TestCase
  test "name is unique" do
    client = Client.new(name: clients(:one).name)
    refute client.valid?
    assert_not_nil client.errors.where(:name, :unique)
  end
end
