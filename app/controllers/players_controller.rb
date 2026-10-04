class PlayersController < ApplicationController
  def show
    @mood = Mood.find(params[:mood_id])

    @playlist = build_playlist(@mood)

    # 再生できる楽曲がない場合
    if @playlist.empty?
      redirect_to root_path, alert: "再生できる楽曲がありません"
      return
    end

    @current_track = @playlist.first
  end

  private

  def build_playlist(mood)
    mood.tracks
        .joins(:youtube_videos)
        .where(youtube_videos: { is_active: true })
        .includes(:game, :youtube_videos)
        .distinct
        .filter_map do |track|
      youtube_video = track.youtube_videos
                           .select(&:is_active)
                           .min_by(&:priority)

      {
        track_id: track.id,
        title: track.title,
        game_title: track.game.title,
        video_id: youtube_video.video_id
      }
    end
    .shuffle
  end
end
