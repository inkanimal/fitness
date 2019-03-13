class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.string :name
      t.datetime :date
      t.string :duration
      t.string :notes
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
