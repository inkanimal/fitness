class Workout < ApplicationRecord
  belongs_to :user
  has_many :worksets, inverse_of: :workout, dependent: :destroy
  has_many :exercises, through: :worksets
  accepts_nested_attributes_for :worksets, allow_destroy: true

  validates :name, presence: true

  # scope :workout_order, -> { order("date DESC")}

  def exercise_num(num)
    num.to_i.times { self.worksets.build.build_exercise } if num
  end

  def self.filter_by_reps(num)
    self.joins(:worksets).where("worksets.reps > ?", num).uniq
  end

  def self.unique_workouts
     Workout.select('DISTINCT(name)')
  end


end
