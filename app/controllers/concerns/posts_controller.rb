class PostsController < ApplicationController

  def top
    @q = Post.ransack(params[:q])

    if params[:q].blank?
      @posts = current_user.posts.page(params[:page])
    else
      @posts = @q.result(distinct: true).where(user_id: current_user.id).order(created_at: :desc).page(params[:page])
    end

    @map_prefs = []
    @posts.pluck(:prefecture).uniq.each do |pref|
      @map_prefs << Post.prefectures[pref]
    end
  end

  def index

    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).released.order(created_at: :desc).page(params[:page])

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


    if @post.update(post_params)
    redirect_to post_path(@post.id)
    else
    render :edit

    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
  end

  def favorite
    favorite_post_ids = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @favorite_posts = Post.where(id: favorite_post_ids).page(params[:page]).per(1)
  end



  private

  def post_params
    params.require(:post).permit(:user_id, :image, :location_name, :address, :latitude, :longitude, :memo, :prefecture, :location_genre, :is_released)
  end

end
