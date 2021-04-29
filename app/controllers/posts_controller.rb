class PostsController < ApplicationController
  before_action :require_login, only: %i[new create edit update destroy]

  def index
    @posts = Post.all.includes(:user).page(params[:page]).order(created_at: :desc).per(15)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "投稿成功"
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path, notice: "投稿を編集しました"
    else
      render :new
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:body, images: [])
    end
end
