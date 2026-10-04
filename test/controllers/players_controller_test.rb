require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  test "指定したmoodの再生ページを表示できる(正常系)" do
    mood = create(:mood)
    track = create(:track)
    create(:track_mood, track: track, mood: mood)
    video = create(:youtube_video, track: track)

    get player_path, params: { mood_id: mood.id }

    assert_response :success

    assert_select "[data-youtube-player-target='gameTitle']", track.game.title
    assert_select "[data-youtube-player-target='trackTitle']", track.title
    assert_select "iframe[src*='#{video.video_id}']"
  end

  test "priorityが最も小さい動画が選ばれる(異常系)" do
    mood = create(:mood)
    track = create(:track)
    create(:track_mood, track: track, mood: mood)
    video1 = create(
      :youtube_video,
      track: track,
      priority: 1
    )

    video2 = create(
      :youtube_video,
      track: track,
      priority: 2
    )

    get player_path, params: { mood_id: mood.id }

    assert_response :success
    assert_select "iframe[src*='#{video1.video_id}']"
    assert_select "iframe[src*='#{video2.video_id}']", count: 0
  end

  test "有効なyoutube_videoがない場合(異常系)" do
    mood = create(:mood)
    track = create(:track)

    create(:track_mood, track: track, mood: mood)
    create(:youtube_video, track: track, is_active: false)

    get player_path, params: { mood_id: mood.id }

    assert_redirected_to root_path
    assert_equal "再生できる楽曲がありません", flash[:alert]
  end
end
