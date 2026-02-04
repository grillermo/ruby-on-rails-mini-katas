class CreateCards < ActiveRecord::Migration[8.1]
  def change
    create_table :cards do |t|
      t.string :token
      t.integer :last4

      t.timestamps
    end
  end
end
