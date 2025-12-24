class Admin::BooksController < ApplicationController
  require 'net/http'
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
    # Google Books APIでタイトルをもとに検索
    title = params[:title]
    @book_info = fetch_book_info(title)

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

  def fetch_book_info(title)
    query = URI.encode_www_form(q: title)
    uri = URI("https://www.googleapis.com/books/v1/volumes?#{query}")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    # 開発環境ではSSL証明書の検証をスキップ（macOSのCRL問題回避）
    http.verify_mode = Rails.env.development? ? OpenSSL::SSL::VERIFY_NONE : OpenSSL::SSL::VERIFY_PEER

    request = Net::HTTP::Get.new(uri)
    response = http.request(request)
    books = JSON.parse(response.body)

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
