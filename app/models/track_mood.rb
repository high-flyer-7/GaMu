class TrackMood < ApplicationRecord
  belongs_to :track
  belongs_to :mood

  validates :mood_id, uniqueness: { scope: :track_id }
end
