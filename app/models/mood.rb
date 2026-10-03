class Mood < ApplicationRecord
  has_many :track_moods
  has_many :tracks, through: :track_moods
end
