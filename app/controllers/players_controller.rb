class PlayersController < ApplicationController
    def show
        @mood = Mood.find(params[:mood_id])
        @track = @mood.tracks.order("RANDOM()").first
        @youtube_video = @track.youtube_videos
                        .where(is_active: true)
                        .order(:priority)
                        .first
    end
end
