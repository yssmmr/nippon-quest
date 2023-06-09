class PostsController < ApplicationController
  def top
    @posts = current_user.posts
  end

  def index
    @posts = Post.all
    @q = Post.ransack(params[:q])
    @post = @q.result(distinct: true).order(created_at: :desc)

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to root_path
    else
      @post = Post.new
      render :new
    end

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
    params.require(:post).permit(:user_id, :image, :location_name, :address, :latitude, :longitude, :memo, :prefecture, :location_genre)
  end
end
