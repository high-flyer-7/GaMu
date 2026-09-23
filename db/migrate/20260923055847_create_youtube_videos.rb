class CreateYoutubeVideos < ActiveRecord::Migration[8.1]
  def change
    create_table :youtube_videos do |t|
      t.references :track, null: false, foreign_key: true
      t.string :video_id
      t.integer :priority
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end

    add_index :youtube_videos, :video_id, unique: true
  end
end
