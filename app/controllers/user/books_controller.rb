class User::BooksController < ApplicationController
  def index
    @q = Book.ransack(params[:q])
    if params[:q].present?
      @books = @q.result(distinct: true)
    else
      @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
    @posts = @book.posts
    @user_posts = current_user.posts.where(book_id: @book.id)
    @like = Like.new
  end
end
