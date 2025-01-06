class Admin::BooksController < ApplicationController
  require 'net/http'
  before_action :authenticate_admin!
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to admin_books_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

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
    # Google Books APIでタイトルをもとに検索
    title = params[:title]
    book_info = fetch_book_info(title)

    if book_info[:error]
      render json: { error: '本が見つかりませんでした。' }
    else
      render json: {
        title: book_info[:title],
        authors: book_info[:authors],
        description: book_info[:description] || '',
        published_date: book_info[:published_date],
        volume: book_info[:volume],
        language: book_info[:language],
        company: book_info[:company]
      }
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

  def fetch_book_info(title)
    query = URI.encode_www_form(q: title)
    url = URI("https://www.googleapis.com/books/v1/volumes?#{query}")

    response = Net::HTTP.get(url)
    books = JSON.parse(response)

    if books['items']
      book_info = books['items'].first['volumeInfo']
      {
        title: book_info['title'],
        authors: book_info['authors']&.join(', '),
        description: book_info['description'],
        published_date: book_info['publishedDate'],
        volume: book_info['pageCount'],
        language: book_info['language'],
        company: book_info['publisher']
      }
    else
      { error: 'No book found' }
    end
  end
end
