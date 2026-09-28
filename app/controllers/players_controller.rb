class PlayersController < ApplicationController
  def show
    @mood = Mood.find(params[:mood_id])

    @playlist = @mood.tracks
                     .includes(:game, :youtube_videos)
                     .filter_map do |track|

      youtube_video = track.youtube_videos
                           .select(&:is_active)
                           .min_by(&:priority)

      next unless youtube_video

      {
        track_id: track.id,
        title: track.title,
        game_title: track.game.title,
        video_id: youtube_video.video_id
      }
    end
    .shuffle

    @current_track = @playlist.first
  end
end