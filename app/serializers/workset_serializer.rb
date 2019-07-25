class WorksetSerializer < ActiveModel::Serializer
  attributes :id, :sets, :reps, :weight

  belongs_to :exercise
  belongs_to :workout
end
