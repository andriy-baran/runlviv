class CreateSupportMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :support_messages do |t|
      t.string :email
      t.text :body

      t.timestamps
    end
  end
end
