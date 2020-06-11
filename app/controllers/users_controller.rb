class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  # def create
  #   @user = User.new(user_params)

  #   if @user.save
  #     render json: @user, status: :created, location: @user
  #   else
  #     render json: @user.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    render json: @user
  end

  def newUsers
    @newUsers = User.where(can_access: false)
    render json: @newUsers
  end

  def teachers
    @teachers = User.where(is_teacher: true)
    render json: @teachers
  end

  def teacher_courses
    @courses = Course.where(teacher_id: current_user.id)
    render json: @courses
  end

  def teacher_sessions
    @sessions = Session.where(course_id: Course.find_by_teacher_id(current_user.id))
    render json: @sessions
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:can_access, :is_admin, :is_teacher)
    end
end
