class ChangeRunsApprovedDefaultValue < ActiveRecord::Migration[5.1]
  def up
    change_column_default :runs, :approved, true
  end

  def down
    change_column_default :runs, :approved, false
  end
end
