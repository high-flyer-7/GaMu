class AddConstraintsToTables < ActiveRecord::Migration[8.1]
  def change
    add_index :track_moods,
              [ :track_id, :mood_id ],
              unique: true,
              name: "index_track_moods_on_track_id_and_mood_id"

    change_column_null :games, :title, false
    change_column_null :tracks, :title, false
    change_column_null :moods, :name, false

    change_column_null :youtube_videos, :video_id, false
    change_column_null :youtube_videos, :priority, false
    change_column_default :youtube_videos, :priority, from: nil, to: 1
  end
end
