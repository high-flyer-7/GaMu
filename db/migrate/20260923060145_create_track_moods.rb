class CreateTrackMoods < ActiveRecord::Migration[8.1]
  def change
    create_table :track_moods do |t|
      t.references :track, null: false, foreign_key: true
      t.references :mood, null: false, foreign_key: true

      t.timestamps
    end
  end
end
