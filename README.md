# TechBook Finder

## 概要
TechBook Finderは「自分に合った難易度のプログラミング本との出会い」をサポートするために開発したアプリです。

技術書には幅広い難易度があります 。ユーザーによる難易度レビューをもとに、自分にぴったりの技術書を見つけることができます

オリジナルプロダクトの URL:https://techbookfinder.com/

## 画面キャプチャ
## 使用技術
- フロントエンド
    - Rails7.1.2
    - Javascript
    - Bootstrap5.3
- バックエンド
    - Rails7.1.2(Ruby3.2.4)
    - Nginx
    - Puma
    - Rspec
    - Rubocop
- データベース
    - MySQL
- インフラ
    - AWS(EC2, VPC, Route53, ACM, ALB, RDS, S3)
## ER 図

![ER図](/app/assets/images/er_diaguram.png)

## インフラ構成図

![インフラ構成図](/app/assets/images/infra.png)

## 機能一覧

### アドミンによる本投稿機能

- GoogleBooksAPIでデータ取得

### 本検索機能

- キーワード検索
- 難易度・カテゴリーなどで絞り込み検索
- 出版順・投稿数順で並び替え

### 本のレビュー投稿機能

### いいね機能

### マイページ機能

### プロフィール機能

### ログイン・ログアウト機能