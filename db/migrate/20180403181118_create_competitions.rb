class CreateCompetitions < ActiveRecord::Migration[5.1]
  def change
    create_table :competitions do |t|
      t.string :title
      t.text :description
      t.date :start
      t.date :finish
      t.references :challenge

      t.timestamps
    end
  end
end
