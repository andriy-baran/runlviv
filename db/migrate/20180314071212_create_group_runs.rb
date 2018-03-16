class CreateGroupRuns < ActiveRecord::Migration[5.1]
  def change
    create_table :group_runs do |t|
      t.string :title
      t.string :place
      t.string :distance
      t.string :tempo
      t.datetime :beginning

      t.timestamps
    end
  end
end
