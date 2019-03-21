class ExercisesController < ApplicationController
   before_action :find_exercise, only: [:show, :destroy]

  def index
    @exercises = Exercise.all
  end

  def show

  end

  def destroy
    @exercise.destroy
    redirect_to exercises_path
  end

  private

  def find_exercise
    @exercise = Exercise.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:name)
  end



end
