class UsersController < ApplicationController

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
      redirect_to user_path(@user)
    end

  end

  def update
    @user = User.find(params[:id])


    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end


  end

  def destroy
    @user = current_user
    @user.update(is_deleted: true)
    sign_out
    redirect_to root_path
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
