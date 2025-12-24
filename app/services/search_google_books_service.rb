require 'net/http'

class SearchGoogleBooksService
  def self.call(title)
    new(title).call
  end

  def initialize(title)
    @title = title
  end

  def call
    book_info = fetch_book_info
    return nil unless book_info

    build_book(book_info)
  end

  private

  def fetch_book_info
    response = request_api
    data = JSON.parse(response.body)
    data['items']&.first&.dig('volumeInfo')
  end

  def request_api
    query = URI.encode_www_form(q: @title)
    uri = URI("https://www.googleapis.com/books/v1/volumes?#{query}")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    # 開発環境ではSSL証明書の検証をスキップ（macOSのCRL問題回避）
    http.verify_mode = Rails.env.development? ? OpenSSL::SSL::VERIFY_NONE : OpenSSL::SSL::VERIFY_PEER

    request = Net::HTTP::Get.new(uri)
    http.request(request)
  end

  def build_book(book_info)
    Book.new(
      title: book_info['title'],
      author: book_info['authors']&.join(', '),
      description: book_info['description'],
      published_day: book_info['publishedDate'],
      volume: book_info['pageCount'],
      language: book_info['language'] == 'ja' ? '日本語' : book_info['language'],
      company: book_info['publisher']
    )
  end
end
