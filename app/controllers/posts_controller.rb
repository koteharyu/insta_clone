class PostsController < ApplicationController
  before_action :require_login, only: %i[new create edit update destroy]

  def index
    @posts = if current_user
                current_user.feed.includes(:user).page(params[:page]).order(created_at: :desc)
              # feedを使わずに取得する場合
              #  my_post = current_user.posts
              #  following_user_posts = []
              #  current_user.following.each do |user|
              #    following_user_posts.push(user.posts)
              #  end
              #  my_post + following_user_posts
             else
               Post.all.includes(:user).page(params[:page]).order(created_at: :desc)
             end

    @users = User.recent(5)
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

  def like_posts
    @posts = current_user.like_posts.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
    render :index
  end

  def search
    # form_withのscopeでsearchを指定することで、searchがパラメーターの頭につく
    @search_form = SearchPostsForm.new(params.require(:search).permit(:body))
    @posts = @search_form.search.includes(:user).page(params[:page])
  end

  private
    def post_params
      params.require(:post).permit(:body, images: [])
    end
end
