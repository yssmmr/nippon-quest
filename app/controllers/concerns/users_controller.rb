class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])

    if @user.is_deleted == false
      @posts = @user.posts.page(params[:page]).per(5)
    else
      redirect_to users_search_path
    end

  end

  def edit
    @user = User.find(params[:id])

    if @user.id == current_user.id
      render :edit
    else
      redirect_to user_path(@user), alert: "▽ユーザー本人でないと編集できません！"
    end

  end

  def update
    @user = User.find(params[:id])


    if @user.update(user_params)
      redirect_to user_path(@user), alert: "▽ユーザーの編集に成功しました！"
    else
      render :edit
    end


  end

  def destroy
    @user = current_user
    @user.update(is_deleted: true)
    @user.posts.destroy_all
    sign_out
    redirect_to root_path, alert: "▽退会処理に成功しました！"
  end


  def search
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).where(is_deleted: false).order(created_at: :desc).page(params[:page]).per(5)
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :account_id, :name, :introduction)
  end
end
