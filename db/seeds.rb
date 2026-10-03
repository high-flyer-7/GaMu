require "csv"

ActiveRecord::Base.transaction do
  # -------------------------
  # Games
  # -------------------------
  CSV.foreach(
    Rails.root.join("db/seeds/games.csv"),
    headers: true
  ) do |row|
    Game.find_or_create_by!(
      title: row["title"]
    )
  end

  # -------------------------
  # Moods
  # -------------------------
  CSV.foreach(
    Rails.root.join("db/seeds/moods.csv"),
    headers: true
  ) do |row|
    Mood.find_or_create_by!(
      name: row["name"]
    )
  end

  # -------------------------
  # Tracks
  # -------------------------
  CSV.foreach(
    Rails.root.join("db/seeds/tracks.csv"),
    headers: true
  ) do |row|
    game = Game.find_by!(
      title: row["game_title"]
    )

    Track.find_or_create_by!(
      game: game,
      title: row["title"]
    )
  end

  # -------------------------
  # YoutubeVideos
  # -------------------------
  CSV.foreach(
    Rails.root.join("db/seeds/youtube_videos.csv"),
    headers: true
  ) do |row|
    game = Game.find_by!(
      title: row["game_title"]
    )

    track = Track.find_by!(
      game: game,
      title: row["track_title"]
    )

    youtube_video = YoutubeVideo.find_or_initialize_by(
      video_id: row["video_id"]
    )

    youtube_video.update!(
      track: track,
      priority: row["priority"].to_i,
      is_active: row["is_active"] == "true"
    )
  end

  # -------------------------
  # TrackMoods
  # -------------------------
  CSV.foreach(
    Rails.root.join("db/seeds/track_moods.csv"),
    headers: true
  ) do |row|
    game = Game.find_by!(
      title: row["game_title"]
    )

    track = Track.find_by!(
      game: game,
      title: row["track_title"]
    )

    mood = Mood.find_by!(
      name: row["mood_name"]
    )

    TrackMood.find_or_create_by!(
      track: track,
      mood: mood
    )
  end
end

puts "Seed completed!"