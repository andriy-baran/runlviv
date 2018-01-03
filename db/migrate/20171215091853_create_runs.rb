class CreateRuns < ActiveRecord::Migration[5.1]
  def change
    create_table :runs do |t|
      t.integer :user_id
      t.string :place
      t.string :distance
      t.string :tempo
      t.datetime :beginning

      t.timestamps null: false
    end

    add_index :runs, :user_id
  end
end
