class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[update destroy]
  before_action :set_user, only: %i[show update destroy logout]
  before_action :correct_user, only: %i[update destroy]

  def index
    @pagy, @users = pagy(User.all, items: 20)

    render json: @users
  end

  def show
    if @user
      render json: @user
    else
      render json: { errors: ['Resource not found'] }, status: :not_found
    end
  end

  def create
    user = User.new(user_params)
    if user.save

      token = JsonWebToken.encode(sub: user.id, email: user.email)
      render json: { token: token, user: {id: user.id, email: user.email} }, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    log_out @user
    @user.destroy
  end

  private

    def set_user
      @user = User.find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:id, :email, :password, :password_confirmation, :avatar)
    end

    # Confirms the current User is the Recipe owner before modify data
    def correct_user
      unless current_user?(@user)
        render json: { errors: ["User not authorized to modify an account that doesn't belong to them"] }, status: :unauthorized
      end
    end
end
