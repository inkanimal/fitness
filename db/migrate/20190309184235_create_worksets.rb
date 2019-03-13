class CreateWorksets < ActiveRecord::Migration[5.2]
  def change
    create_table :worksets do |t|
      t.integer :sets
      t.integer :reps
      t.integer :weight
      t.references :exercise, foreign_key: true
      t.references :workout, foreign_key: true

      t.timestamps
    end
  end
end
