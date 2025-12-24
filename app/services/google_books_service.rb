require 'net/http'

class GoogleBooksService
  def initialize(title)
    @title = title
  end

  def call
    book_info = fetch_book_info

    if book_info[:error]
      { book: Book.new, error_message: "本が見つかりませんでした。" }
    else
      { book: build_book(book_info), error_message: nil }
    end
  end

  private

  def fetch_book_info
    query = URI.encode_www_form(q: @title)
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

  def build_book(book_info)
    Book.new(
      title: book_info[:title],
      author: book_info[:authors],
      description: book_info[:description],
      published_day: book_info[:published_date],
      volume: book_info[:volume],
      language: book_info[:language] == 'ja' ? '日本語' : book_info[:language],
      company: book_info[:company]
    )
  end
end
