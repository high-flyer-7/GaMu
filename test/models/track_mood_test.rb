require "test_helper"

class TrackMoodTest < ActiveSupport::TestCase
  test "同じtrackとmoodを重複して登録できない" do
    track = create(:track)
    mood = create(:mood)

    create(:track_mood, track: track, mood: mood)

    duplicate = build(:track_mood, track: track, mood: mood)

    assert_not duplicate.valid?
  end
end
