class User::BooksController < ApplicationController
  def index
    @q = Book.ransack(params[:q])
    @categories = Book.pluck(:category).uniq
    @books = @q.result(distinct: true)
  end

  def show
    @book = Book.find(params[:id])
    @posts = @book.posts
    if user_signed_in?
      @user_posts = current_user.posts.where(book_id: @book.id)
      @like = Like.new
    end
  end
end
