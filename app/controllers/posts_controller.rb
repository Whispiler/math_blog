class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  def index
    if params[:keyword].present?
      @posts = Post.includes(:user)
                   .where("title LIKE ?", "%#{params[:keyword]}%")
                   .order(created_at: :desc)
    else
      @posts = Post.includes(:user)
                   .order(created_at: :desc)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
        tags = params[:tag_names].to_s.split(",")

        tags.each do |tag_name|
          tag = Tag.find_or_create_by(name: tag_name.strip)
          @post.tags << tag
        end

        redirect_to @post, notice: "記事を投稿しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "記事を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "記事を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, tag_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    redirect_to posts_path, alert: "権限がありません" unless @post.user == current_user
  end
end
