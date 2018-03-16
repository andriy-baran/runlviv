class AddGroupRunIdToRuns < ActiveRecord::Migration[5.1]
  def change
    add_reference :runs, :group_run, index: true
  end
end
