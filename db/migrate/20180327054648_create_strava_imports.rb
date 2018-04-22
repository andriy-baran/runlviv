class CreateStravaImports < ActiveRecord::Migration[5.1]
  def change
    create_table :strava_imports do |t|
      t.references :user, foreign_key: true
      t.integer :strava_id
      t.float :distance
      t.string :name
      t.float :avg_speed
      t.datetime :beginning

      t.timestamps
    end
  end
end
