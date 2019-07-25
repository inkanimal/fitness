class WorkoutSerializer < ActiveModel::Serializer
  attributes :id, :name, :date, :duration, :notes

  has_many :worksets
  has_many :exercises, through: :worksets
  belongs_to :user
end
