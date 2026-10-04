require "test_helper"

class MoodTest < ActiveSupport::TestCase
  test "紐づいているtrackを取得できる" do
    mood = create(:mood)
    track = create(:track)

    create(:track_mood, track: track, mood: mood)

    assert_includes mood.tracks, track
  end
end
