class CreateCells < ActiveRecord::Migration[5.2]
  def change
    create_table :cells do |t|
      t.integer :x_axis
      t.integer :y_axis
      t.boolean :filled, default: false
      t.references :color, foreign_key: true
      t.references :user, foreign_key: true
      t.references :board, foreign_key: true

      t.timestamps
    end
  end
end
