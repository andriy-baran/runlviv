class AddRulesToCompetitions < ActiveRecord::Migration[5.1]
  def change
    add_column :competitions, :rules, :jsonb, null: :false, default: {}
  end
end
