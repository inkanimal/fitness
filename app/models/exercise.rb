class Exercise < ApplicationRecord
  has_many :worksets
  has_many :workouts, through: :worksets

  validates_presence_of :name

  scope :exercise_order, -> { order("name")}

  # def self.exercise_order
  #   order("name")
  # end

  

end
