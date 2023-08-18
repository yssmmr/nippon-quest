class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).where(is_deleted: false).order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])

    if @user.is_deleted == false
      @posts = @user.posts.all.page(params[:page])
    else
      redirect_to admin_users_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    redirect_to admin_users_path, alert: "▽退会処理に成功しました！"
  end
end
