# app/models/track.rb
class Track < ApplicationRecord
  belongs_to :game

  has_many :track_moods
  has_many :moods, through: :track_moods

  has_many :youtube_videos
end
