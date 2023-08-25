class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def show
    @user = User.find(params[:id])
    @followings = @user.followings
    @followers = @user.followers
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  # フォロー一覧
  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  # フォロワー一覧
  def followers
    user = User.find(params[:id])
    @user = user.followers
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
