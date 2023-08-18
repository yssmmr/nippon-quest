class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_viewer!, only: :show

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
    if params[:follow].present?
      @follow = params[:follow]
    else
      @follow = false
    end

    @q = Post.ransack(params[:q])
    @user = current_user.followings
    @posts = @q.result(distinct: true).released.order(created_at: :desc).page(params[:page])

    if @follow == 'true'
      @posts = @q.result(distinct: true).where(user: @user).released.order(created_at: :desc).page(params[:page])
    end

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_top_path, alert: "▽投稿に成功しました！"
    else
      render :new
    end

  end

  def edit
    @post = Post.find(params[:id])

    unless @post.user.id == current_user.id
      redirect_to post_path(@post.id)
    end

  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_path(@post.id), alert: "▽編集に成功しました！"
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, alert: "▽削除に成功しました！"
  end

  def show
    @post = Post.find(params[:id])
  end

  def favorite
    favorite_post_ids = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @favorite_posts = Post.where(id: favorite_post_ids).page(params[:page]).per(5)
  end



  private

  def post_params
    params.require(:post).permit(:user_id, :image, :location_name, :address, :latitude, :longitude, :memo, :prefecture, :location_genre, :released_flag)
  end

  def authenticate_viewer!
    post = Post.find(params[:id])
    unless post.showable?(current_user)
      redirect_to root_path, alert: "▽投稿者でないと閲覧できません！"
    end
  end
end
