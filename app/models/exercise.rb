class Exercise < ApplicationRecord
  has_many :worksets
  has_many :workouts, through: :worksets

  validates_presence_of :name
end
