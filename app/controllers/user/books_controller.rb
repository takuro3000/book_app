class User::BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @posts = @book.posts
    @like = Like.new
  end
end
