class WorkoutsController < ApplicationController
  before_action :find_workout, only: [:show, :edit, :update, :destroy, :next]

  def index
    @workouts = Workout.all
    respond_to do |f|
      f.html
      f.json {render json: @workouts}
    end
    @workouts = current_user.id
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
      render json: @workout
    else
      flash[:errors] = @workout.errors.full_messages
      redirect_to new_workout_path
    end
  end

  def next
    @next_workout = @workout.next
    render json: @next_workout
  end
  
  def show
    respond_to do |f|
      f.html
      f.json {render json: @workout}
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
    respond_to do |f|
      f.html
      f.json {render json: @workout}
    end
    @user = @workout.user
  end

  def workout_params
    params.require(:workout).permit(:id,
      :name, :date, :duration, :notes,
      worksets_attributes: [:_destroy, :sets, :reps, :weight,
        exercise_attributes: [:_destroy, :name]
        ])
  end
end
