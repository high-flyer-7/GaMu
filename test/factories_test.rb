require "test_helper"

class FactoriesTest < ActiveSupport::TestCase
  test "all factories are valid" do
    assert_nothing_raised do
      FactoryBot.lint
    end
  end
end
