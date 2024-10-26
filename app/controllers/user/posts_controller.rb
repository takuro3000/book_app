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

  def edit
    @book = Book.find(params[:book_id])
    @post = current_user.posts.where(book_id: @book.id)[0]
  end

  def update
    @book = Book.find(params[:book_id])
    @post = current_user.posts.where(book_id: @book.id)[0]
    if @post.update(post_params)
      @post.update(user_id: current_user.id)
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  private
  def post_params
    params.require(:post).permit(:difficulty, :content)
  end
end
