class AddCompetitionToRuns < ActiveRecord::Migration[5.1]
  def change
    add_reference :runs, :competition, index: true
    add_column :runs, :approved, :boolean, default: false
    add_reference :strava_imports, :run
  end
end
