class WorksetsController < ApplicationController

before_action :find_workset, only: [:show, :edit, :update, :destroy]

def index
  @workout = Workout.find(params[:workout_id])
  @worksets = @workout.worksets
end

def new
  @workout = Workout.find(params[:workout_id])
  @workset = @workout.worksets.build
  @workset.build_exercise

end

def show
end

def create
  @workout = Workout.find(params[:workout_id])
  # binding.pry
  @workset = @workout.worksets.build(workset_params)
  if @workset.save
    redirect_to workout_workset_path(@workout, @workset)
  else
    render :new
  end
end

private

def find_workset
  @workset = Workset.find(params[:id])
  @workout = @workset.workout
end

def workset_params
  params.require(:workset).permit(
    :sets, :reps, :weight,
      exercise_attributes: [:_destroy, :name])
end

end
