class WorkoutsController < ApplicationController
  before_action :find_workout, only: [:show, :edit, :update, :destroy]

  def index
    @workouts = Workout.all
  end

  def show
  end

  def new
    @workout = Workout.new
    @workout.exercise_num(params[:exercise_num])
  end

  def create
    @workout = Workout.new(workout_params)
    #@workout.worksets
    @workout.user_id = current_user.id
    if @workout.valid?
      @workout.save
      redirect_to @workout
    else
      flash[:errors] = @workout.errors.full_messages
      redirect_to new_workout_path
    end
  end

  def edit
  end

  def update
    @workout.assign_attributes(workout_params)
    if @workout.valid?
      @workout.delete_exercises
      @workout.update_attributes(workout_params)
      redirect_to @workout
    else
      flash[:errors] = @workout.errors.full_messages
      redirect_to edit_workout_path(@workout)
    end
  end

  def destroy
    @workout.delete_workout
    redirect_to @user

  redirect_to workouts_path
  end

  private

  def find_workout
    @workout = Workout.find(params[:id])
    @user = @workout.user
  end

  def workout_params
    params.require(:workout).permit(
      :name, :date, :duration, :notes,
      worksets_attributes: [:_destroy, :sets, :reps, :weight,
        exercise_attributes: [:_destroy, :name]
        ])
  end
end
