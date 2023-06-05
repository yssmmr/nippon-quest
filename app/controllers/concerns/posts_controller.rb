class PostsController < ApplicationController
  def top
    @posts = current_user.posts
  end

  def index

  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save
    redirect_to root_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end

  private

  def post_params
    params.require(:post).permit(:user_id,:location_name, :address, :latitude, :longitude, :memo, :prefecture, :location_genre)
  end
end
