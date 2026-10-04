class YoutubeVideo < ApplicationRecord
  belongs_to :track

  validates :video_id, presence: true, uniqueness: true
end
