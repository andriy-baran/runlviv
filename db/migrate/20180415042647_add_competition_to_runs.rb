class AddCompetitionToRuns < ActiveRecord::Migration[5.1]
  def change
    add_reference :runs, :competition, index: true
  end
end
