# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# 開発環境のみでサンプルデータを作成
if Rails.env.development?
  puts "=== 開発環境用サンプルデータを作成します ==="

  # ========================================
  # 管理者データ
  # ========================================
  puts "管理者を作成中..."
  
  admin = Admin.find_or_initialize_by(custom_id: "admin001")
  admin.password = "password123"
  admin.save!
  
  puts "✅ 管理者を作成しました (custom_id: admin001, password: password123)"

  # ========================================
  # ユーザーデータ
  # ========================================
  puts "ユーザーを作成中..."

  users_data = [
    { name: "田中太郎", level: "初級エンジニア", self_introduction: "Rubyを勉強中の駆け出しエンジニアです。" },
    { name: "山田花子", level: "中級エンジニア", self_introduction: "Web開発を3年やっています。最近はRailsにハマっています。" },
    { name: "佐藤次郎", level: "上級エンジニア", self_introduction: "10年以上の経験があります。アーキテクチャ設計が得意です。" },
    { name: "鈴木美咲", level: "初級エンジニア", self_introduction: "文系出身ですが、プログラミングの楽しさに目覚めました！" },
    { name: "高橋健太", level: "中級エンジニア", self_introduction: "バックエンドもフロントエンドも両方やってます。" }
  ]

  created_users = []
  users_data.each do |user_data|
    user = User.find_or_initialize_by(name: user_data[:name])
    user.password = "password123"
    user.level = user_data[:level]
    user.self_introduction = user_data[:self_introduction]
    user.save!
    created_users << user
  end

  puts "✅ #{created_users.count}人のユーザーを作成しました"

  # ========================================
  # 書籍データ（実在するプログラミング書籍）
  # ========================================
  puts "書籍を作成中..."

  books_data = [
    {
      title: "プロを目指す人のためのRuby入門",
      author: "伊藤淳一",
      description: "Rubyの基礎から実践的な内容まで、プロのエンジニアを目指す人に必要な知識を網羅した一冊。テストの書き方やデバッグ方法なども詳しく解説。",
      company: "技術評論社",
      category: "Ruby",
      language: "日本語",
      volume: 520,
      published_day: Date.new(2021, 12, 2),
      link: "https://gihyo.jp/book/2021/978-4-297-12437-3"
    },
    {
      title: "パーフェクト Ruby on Rails",
      author: "すがわらまさのり、前島真一、橋立友宏、五十嵐邦明",
      description: "Railsの基本から実践的なテクニックまで、現場で使えるノウハウを凝縮。Rails 7対応の改訂版。",
      company: "技術評論社",
      category: "Ruby on Rails",
      language: "日本語",
      volume: 496,
      published_day: Date.new(2020, 7, 25),
      link: "https://gihyo.jp/book/2020/978-4-297-11462-6"
    },
    {
      title: "リーダブルコード",
      author: "Dustin Boswell、Trevor Foucher",
      description: "より良いコードを書くためのシンプルで実践的なテクニック。コードの可読性を高める方法を具体例とともに解説。",
      company: "オライリー・ジャパン",
      category: "プログラミング全般",
      language: "日本語",
      volume: 260,
      published_day: Date.new(2012, 6, 23),
      link: "https://www.oreilly.co.jp/books/9784873115658/"
    },
    {
      title: "達人プログラマー",
      author: "David Thomas、Andrew Hunt",
      description: "ソフトウェア開発のベストプラクティスと職人的な開発姿勢を学べる名著。第2版で内容が大幅にアップデート。",
      company: "オーム社",
      category: "プログラミング全般",
      language: "日本語",
      volume: 408,
      published_day: Date.new(2020, 11, 21),
      link: "https://www.ohmsha.co.jp/book/9784274226298/"
    },
    {
      title: "JavaScript Primer",
      author: "azu、Suguru Inatomi",
      description: "ES2015以降のモダンなJavaScriptを基礎からしっかり学べる入門書。Web上でも無料で読める。",
      company: "アスキードワンゴ",
      category: "JavaScript",
      language: "日本語",
      volume: 392,
      published_day: Date.new(2020, 4, 27),
      link: "https://jsprimer.net/"
    },
    {
      title: "Webを支える技術",
      author: "山本陽平",
      description: "HTTP、URI、HTML、REST...Webを支える基盤技術を体系的に学べる一冊。Web開発者必読の定番書。",
      company: "技術評論社",
      category: "Web技術",
      language: "日本語",
      volume: 400,
      published_day: Date.new(2010, 4, 8),
      link: "https://gihyo.jp/book/2010/978-4-7741-4204-3"
    },
    {
      title: "SQLアンチパターン",
      author: "Bill Karwin",
      description: "データベース設計やSQLでよくある間違いパターンとその解決策を解説。データベースを扱うすべてのエンジニアにおすすめ。",
      company: "オライリー・ジャパン",
      category: "データベース",
      language: "日本語",
      volume: 352,
      published_day: Date.new(2013, 1, 26),
      link: "https://www.oreilly.co.jp/books/9784873115894/"
    },
    {
      title: "Docker/Kubernetes実践コンテナ開発入門",
      author: "山田明憲",
      description: "DockerとKubernetesの基礎から実践的な使い方まで、コンテナ技術を体系的に学べる入門書。",
      company: "技術評論社",
      category: "インフラ",
      language: "日本語",
      volume: 464,
      published_day: Date.new(2018, 8, 25),
      link: "https://gihyo.jp/book/2018/978-4-297-10033-9"
    },
    {
      title: "オブジェクト指向設計実践ガイド",
      author: "Sandi Metz",
      description: "Rubyを使ってオブジェクト指向設計の原則とベストプラクティスを学ぶ。実践的なリファクタリング手法も解説。",
      company: "技術評論社",
      category: "設計",
      language: "日本語",
      volume: 304,
      published_day: Date.new(2016, 9, 2),
      link: "https://gihyo.jp/book/2016/978-4-7741-8361-9"
    },
    {
      title: "プログラミング TypeScript",
      author: "Boris Cherny",
      description: "TypeScriptの型システムを深く理解し、安全で堅牢なコードを書くための包括的なガイド。",
      company: "オライリー・ジャパン",
      category: "TypeScript",
      language: "日本語",
      volume: 352,
      published_day: Date.new(2020, 3, 16),
      link: "https://www.oreilly.co.jp/books/9784873119045/"
    },
    {
      title: "Clean Code",
      author: "Robert C. Martin",
      description: "きれいなコードを書くための原則、パターン、プラクティスを解説。ソフトウェア開発者のバイブル的存在。",
      company: "アスキードワンゴ",
      category: "プログラミング全般",
      language: "日本語",
      volume: 464,
      published_day: Date.new(2017, 12, 18),
      link: "https://asciidwango.jp/post/168584306145/clean-code"
    },
    {
      title: "マスタリングTCP/IP 入門編",
      author: "井上直也、村山公保、竹下隆史、荒井透、苅田幸雄",
      description: "ネットワークの基礎をTCP/IPプロトコルを中心に体系的に解説。ネットワーク入門の定番書。",
      company: "オーム社",
      category: "ネットワーク",
      language: "日本語",
      volume: 400,
      published_day: Date.new(2019, 12, 1),
      link: "https://www.ohmsha.co.jp/book/9784274224478/"
    }
  ]

  sample_image_path = Rails.root.join("spec/fixtures/files/sample_book.jpg")
  
  created_books = []
  books_data.each do |book_data|
    book = Book.find_or_initialize_by(title: book_data[:title])
    book.assign_attributes(book_data.except(:title))
    
    # 画像を添付（既に添付されていない場合のみ）
    unless book.image.attached?
      book.image.attach(
        io: File.open(sample_image_path),
        filename: "#{book_data[:title].parameterize}.jpg",
        content_type: "image/jpeg"
      )
    end
    
    book.save!
    created_books << book
  end

  puts "✅ #{created_books.count}冊の書籍を作成しました"

  # ========================================
  # 投稿（レビュー）データ
  # ========================================
  puts "投稿を作成中..."

  reviews = [
    { difficulty: 2, content: "初心者にも分かりやすく書かれていて、とても勉強になりました。練習問題も豊富で実践的です。" },
    { difficulty: 3, content: "基礎から応用まで幅広くカバーされています。リファレンスとしても使えます。" },
    { difficulty: 1, content: "プログラミング初心者でも読みやすかったです。コードの例が豊富で理解しやすい。" },
    { difficulty: 4, content: "内容は深いですが、ある程度の経験があれば非常に有益です。実務で役立つ知識が満載。" },
    { difficulty: 5, content: "かなり高度な内容も含まれています。中上級者向けですが、読み応えがあります。" },
    { difficulty: 2, content: "図解が多くて視覚的に理解しやすいです。何度も読み返しています。" },
    { difficulty: 3, content: "現場で使えるテクニックが多く紹介されています。実践的な内容でおすすめです。" }
  ]

  post_count = 0
  created_books.each_with_index do |book, book_index|
    # 各本に対して1〜3件のランダムなレビューを作成
    num_reviews = [1, 2, 3].sample
    selected_users = created_users.sample(num_reviews)
    
    selected_users.each_with_index do |user, user_index|
      review = reviews[(book_index + user_index) % reviews.length]
      
      # 既存の投稿がなければ作成
      unless Post.exists?(user_id: user.id, book_id: book.id)
        Post.create!(
          user: user,
          book: book,
          difficulty: review[:difficulty],
          content: review[:content]
        )
        post_count += 1
      end
    end
  end

  puts "✅ #{post_count}件の投稿を作成しました"

  puts "=== サンプルデータの作成が完了しました ==="
  puts ""
  puts "【ログイン情報】"
  puts "  管理者: custom_id: admin001 / password: password123"
  puts "  ユーザー: 各ユーザー名でログイン / password: password123"
end
