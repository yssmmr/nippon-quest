class Admin::PostsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @posts = Post.all.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy

  end

end
