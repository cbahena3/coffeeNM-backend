class UsersController < ApplicationController
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
    render :show
  end
end
