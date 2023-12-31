class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :email
      t.integer :width
      t.integer :height
      t.integer :number_of_mines
      t.string :name
      t.string :tiles, array: true, default: []

      t.timestamps
    end
  end
end
