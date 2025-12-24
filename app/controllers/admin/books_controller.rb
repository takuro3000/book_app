class Admin::BooksController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @books = Book.all
  end

  def show; end

  def new
    @book = Book.new
  end

  def edit; end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to admin_books_path
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to admin_books_path
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to admin_books_path
  end

  def search
    @book = SearchGoogleBooksService.call(params[:title])

    if @book.nil?
      @book = Book.new
      @error_message = "本が見つかりませんでした。"
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(
      :title, :description, :image, :volume, :published_day, :language,
      :company, :link ,:author ,:category
    )
  end
end
