# TechBook Finder
URL:https://techbookfinder.com/

![トップ画像](/app/assets/images/home_page.png)

## 概要
TechBook Finderは「自分に合った難易度のプログラミング本との出会い」をサポートするために開発したアプリです。

技術書には幅広い難易度があり、「思っていたより難しくて挫折した」「簡単すぎて得るものがなかった」といった経験をしたことがある人も多いでしょう。TechBook Finderでは、ユーザーによる難易度レビューをもとに、自分のスキルレベルに合った技術書を見つけることができます。

## 機能一覧

### 管理者機能

**本投稿機能**

### 一般ユーザー機能

**本検索機能**

**本のレビュー投稿機能**

**いいね機能**

**マイページ機能**

**プロフィール機能**

**ログイン・ログアウト機能**

## 使用技術
- フロントエンド
    - Ruby on Rails 7.1.2
    - JavaScript
    - Bootstrap 5.3
- バックエンド
    - Ruby on Rails 7.1.2(Ruby3.2.4)
    - Rspec
    - Rubocop
- データベース
    - MySQL
- インフラ
    - AWS(EC2, VPC, Route53, ACM, ALB, RDS, S3)
    - Nginx
    - Puma
- バージョン管理
    - Git/GitHub
- API
    - Google Books API
## ER 図

![ER図](/app/assets/images/er_diaguram.png)

## インフラ構成図

![インフラ構成図](/app/assets/images/infra.png)

## ページ一覧


| ページ名                       | ページ名                      |
|--------------------------------|-------------------------------|
| **ホームページ**              | **新規登録・ログインページ** |
| <img src="/app/assets/images/home_page.png" alt="ホームページ" style="width:100%; max-width:300px;"> | <img src="/app/assets/images/login.png" alt="新規登録・ログインページ" style="width:100%; max-width:300px;"> |
| ・アプリの概要を説明しています  <br> ・レビューの多い本、初級者・中級者・上級者向けの本、新しい本を見れるようになっています | ・nameとpasswordで新規登録します <br> ・アプリで発行されたcustom_idとpasswordでログインします |
| **本検索ページ**              | **本詳細ページ**             |
| <img src="/app/assets/images/search.png" alt="本検索ページ" style="width:100%; max-width:300px;"> | <img src="/app/assets/images/show.png" alt="本詳細ページ" style="width:100%; max-width:300px;"> |
| ・タイトルや著者でキーワード検索できます <br> ・難易度・カテゴリーで絞り込んで検索できます <br> ・投稿数の多い順、出版の新しい順に並び変えることができます | ・本の難易度、概要について表示しています <br> ・本に対するユーザーのレビューが表示しています <br> ・ユーザーのレビューに対しいいねが押せます |
| **レビュー投稿・編集ページ**  | **マイページ**               |
| <img src="/app/assets/images/post.png" alt="レビュー投稿・編集ページ" style="width:100%; max-width:300px;"> | <img src="/app/assets/images/mypage.png" alt="マイページ" style="width:100%; max-width:300px;"> |
| ・難易度と感想を投稿します       | ・紹介文や自分のレベルなどが表示でき、編集ページに飛ぶことができます <br> ・ユーザーがレビューした本の一覧が表示されています |
| **プロフィール編集ページ**  | **Aboutページ**              |
| <img src="/app/assets/images/profile.png" alt="プロフィール編集ページ" style="width:100%; max-width:300px;"> | <img src="/app/assets/images/about.png" alt="Aboutページ" style="width:100%; max-width:300px;"> |
| ・ユーザー名、紹介文、アイコン、自分のレベルなどを編集することができます | ・初めて訪問されたユーザーでもわかるように、アプリのコンセプトや使い方を記載しています |
| **管理者　本投稿ページ**        |                               |
| <img src="/app/assets/images/new_book.png" alt="Admin本投稿ページ" style="width:100%; max-width:300px;"> |                               |
| ・管理者のみ本を投稿することができます <br> ・Google Books APIを利用して利用して本の情報を登録することができ、手動で入力する手間を省けます |                               |
