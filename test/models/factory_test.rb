require "test_helper"

class FactoryTest < ActiveSupport::TestCase
  test "全てのfactoryからレコードを作成できる" do
    assert create(:game).persisted?
    assert create(:track).persisted?
    assert create(:mood).persisted?
    assert create(:track_mood).persisted?
    assert create(:youtube_video).persisted?
  end
end
