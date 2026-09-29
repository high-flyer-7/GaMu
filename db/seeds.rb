game = Game.create!(
  title: "ファイナルファンタジーIX"
)

track = Track.create!(
  game: game,
  title: "あの丘を越えて"
)

YoutubeVideo.create!(
  track: track,
  video_id: "NcllQRpnLXQ",
  priority: 1,
  is_active: true
)

mood = Mood.create!(
  name: "落ち着いた"
)

TrackMood.create!(
  track: track,
  mood: mood
)