class RelationshipsController < ApplicationController
  before_action :authenticate_user!

 # フォローするとき
  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])
    current_user.create_notification_follow!(current_user, @user)
    redirect_to request.referer
  end

  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings.page(params[:page]).per(5)
  end

  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page]).per(5)
  end
end