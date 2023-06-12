class PostsController < ApplicationController
  def top
    @posts = current_user.posts
  end

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).order(created_at: :desc)

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
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])


    if @post.update!(post_params)
    redirect_to post_path(@post.id)
    else
    render :edit

    end
  end

  def destroy
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :image, :location_name, :address, :latitude, :longitude, :memo, :prefecture, :location_genre)
  end
end
