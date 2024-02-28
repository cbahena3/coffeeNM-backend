class UsersController < ApplicationController
  before_action :authenticate_user, except: [:index, :show, :create]

  def with_password
    params.permit(:name, :image, :email, :password, :password_confirmation)
  end

  def without_password
    params.permit(:name, :image, :email)
  end

  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find_by(id: params[:id])
    render :show
  end

  def create
    @user = User.create(
      name: params[:name],
      image: params[:image],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if @user.valid?
      render :show, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    if current_user.id == @user.id
      if params[:password].present?
        @user.update(with_password)
      else
        @user.update(without_password)
      end
      render :show
    else
      render json: { errors: "You are not authorized to perform this action" }, status: :unauthorized
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    render json:{message: "User deleted"}
  end

end
