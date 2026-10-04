require "test_helper"

class YoutubeVideoTest < ActiveSupport::TestCase
  test "trackに紐づけられる" do
    track = create(:track)
    video = create(:youtube_video, track: track)

    assert_equal track, video.track
  end

  test "video_idがない場合は無効" do
  video = build(:youtube_video, video_id: nil)

  assert_not video.valid?
  end
end
