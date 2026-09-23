class TrackMood < ApplicationRecord
  belongs_to :track
  belongs_to :mood
end
