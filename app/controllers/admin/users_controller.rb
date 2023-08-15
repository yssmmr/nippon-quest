class Admin::UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).where(is_deleted: false).order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all.page(params[:page])
  end

  def destroy

  end

end
