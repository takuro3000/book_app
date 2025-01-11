FactoryBot.define do
  factory :book do
    title          { "サンプルタイトル" }
    description    { "この本の簡単な説明です。" }
    volume         { rand(1..10) }
    published_day  { Faker::Date.backward(days: 365 * 5) }
    language       { "日本語" }
    company        { "出版社名" }
    link           { "https://example.com/book" }
    author         { "著者名" }
    category       { "小説" }

    # 画像を添付する処理
    after(:build) do |book|
      # spec/fixtures/files/sample.jpg を画像ファイルとして添付
      file_path = Rails.root.join("spec/fixtures/files/sample_book.jpg")
      book.image.attach(io: File.open(file_path), filename: 'sample_book.jpg', content_type: 'image/jpeg')
    end
  end
end
