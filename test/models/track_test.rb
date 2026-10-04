require "test_helper"

class TrackTest < ActiveSupport::TestCase
  test "gameに紐づけられる" do
    game = create(:game)
    track = create(:track, game: game)

    assert_equal game, track.game
  end

  test "moodに紐づけられる" do
    track = create(:track)
    mood = create(:mood)

    create(:track_mood, track: track, mood: mood)

    assert_includes track.moods, mood
  end

  test "youtube_videoに紐づけられる" do
    track = create(:track)
    video = create(:youtube_video, track: track)

    assert_includes track.youtube_videos, video
  end
end
