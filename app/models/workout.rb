class Workout < ApplicationRecord
  belongs_to :user
  has_many :worksets, inverse_of: :workout, dependent: :destroy
  has_many :exercises, through: :worksets
  accepts_nested_attributes_for :worksets, allow_destroy: true

  validates :name, presence: true

  def exercise_num(num)
    num.to_i.times { self.worksets.build.build_exercise } if num
  end


  def delete_worksets
    self.worksets.destroy_all
  end
end
