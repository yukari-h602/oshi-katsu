class RelationshipsController < ApplicationController
  before_action :set_user_follow, only: %i[followings followers]
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings
    @users = user.followings
  end

  def followers
    @users = user.followers
  end

  private
  def set_user_follow
    user = User.find(params[:user_id])
  end
end
