class WorkoutsController < ApplicationController
  before_action :find_workout, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  def index
    # @workouts = current_user.id

    # @workouts = Workout.where(:user_id => current_user.id)
    if params[:user_id]
       @user = User.find(params[:user_id])
       @workouts = @user.workouts
    elsif params[:fitler_by_reps]
      @workouts = Workout.filter_by_reps(params[:fitler_by_reps])
      @workouts.uniq
    else
      @workouts = Workout.all
    end
  end

  def show
  end


  def new
    @workout = Workout.new
    @workout.exercise_num(params[:exercise_num])
  end

  def create
    @workout = Workout.new(workout_params)
    @workout.user_id = current_user.id
    if @workout.valid?
      @workout.save
      redirect_to @workout
    else
      flash[:errors] = @workout.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    @workout.assign_attributes(workout_params)
    if @workout.valid?
      @workout.delete_worksets
      @workout.update_attributes(workout_params)
      # @workout.save
      redirect_to @workout
    else
      flash[:errors] = @workout.errors.full_messages
      redirect_to edit_workout_path(@workout)
    end
  end

  def destroy
    @workout.destroy
    redirect_to @workout
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
