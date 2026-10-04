FactoryBot.define do
  factory :youtube_video do
    track
    sequence(:video_id) { |n| "video_#{n}" }
    priority { 1 }
    is_active { true }
  end
end
