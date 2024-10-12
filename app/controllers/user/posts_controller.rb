class User::PostsController < ApplicationController
  def index
  end

  def new
    @post = Post.new
    @book = Book.find(params[:book_id])
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

  private
  def post_params
    params.require(:post).permit(:difficulty, :content)
  end
end
