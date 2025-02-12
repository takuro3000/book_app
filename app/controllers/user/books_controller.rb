class User::BooksController < ApplicationController
  def index
    @q = Book.ransack(params[:q])
    @categories = Book.distinct.pluck(:category)
    @books = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @book = Book.find(params[:id])
    @posts = @book.posts
    if user_signed_in?
      @user_post = current_user.posts.find_by(book_id: @book.id)
      @like = Like.new
    end
  end
end
