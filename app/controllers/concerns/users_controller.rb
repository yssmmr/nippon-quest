class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts

  end

  def edit
    @user = User.find(params[:id])

    if @user.id == current_user.id
      render :edit
    else
      redirect_to root_path
    end

  end

  def update
    @user = User.find(params[:id])


    if @user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end


  end

  def destroy
    @user = current_user
    @user.update(is_deleted: true)
    sign_out
    redirect_to about_path

  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :account_id, :name, :introduction)
  end
end
