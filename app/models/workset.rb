class Workset < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout
  accepts_nested_attributes_for :exercise, allow_destroy: true


  validates_presence_of :sets
  validates_presence_of :reps
  validates_presence_of :weight 
end
