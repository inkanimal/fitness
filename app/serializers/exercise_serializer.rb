class ExerciseSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :worksets
  has_many :workouts, through: :worksets
end
