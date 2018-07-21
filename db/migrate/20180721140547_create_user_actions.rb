class CreateUserActions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_actions do |t|
      t.references :user, foreign_key: true
      t.references :board, foreign_key: true
      t.references :cell, foreign_key: true
      t.references :color, foreign_key: true
      t.integer :action_count, default: 0

      t.timestamps
    end
  end
end
