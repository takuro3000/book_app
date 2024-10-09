class Admin::BooksController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_book, only: %i[show edit update]

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to admin_book_path(@book)
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @book.update(book_params)
      redirect_to admin_book_path(@book)
    else
      render :edit
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:product).permit(:name, :description)
  end
end
