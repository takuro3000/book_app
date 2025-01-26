class User::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book_and_post, only: %i[edit update]
  before_action :authorize_user!, only: %i[edit update]

  def new
    @post = Post.new
    @book = Book.find(params[:book_id])
  end

  def edit
  end

  def create
    @book = Book.find(params[:book_id])
    @post = @book.posts.build(post_params) # @bookに関連する投稿を作成
    @post.user_id = current_user.id
    if @post.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  private
  def set_book_and_post
    @book = Book.find(params[:book_id])
    @post = @book.posts.find(params[:id])
  end

  def authorize_user!
    redirect_to root_path, alert: "この投稿を編集する権限がありません。" if @post.user_id != current_user.id
  end

  def post_params
    params.require(:post).permit(:difficulty, :content)
  end
end
