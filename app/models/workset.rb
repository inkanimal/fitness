class Workset < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout
  accepts_nested_attributes_for :exercise, allow_destroy: true


  def exercise_attributes=(exercise)
  
    self.exercise = Exercise.find_or_create_by(name: exercise["name"])
    self.exercise.update(exercise)
  end
  # find or create by name for Exercise

  validates_presence_of :sets
  validates_presence_of :reps
  validates_presence_of :weight
end
