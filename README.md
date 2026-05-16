# README

# Math Blog

数学・プログラミングに関する記事を投稿できる技術ブログサービスです。
Markdown / LaTeX に対応しており、コードハイライト付きの記事投稿ができます。

Docker を用いて開発環境を構築し、
本番環境では Render + PostgreSQL を利用してデプロイしています。

# URL

https://math-blog-gwc5.onrender.com

# 使用技術

## バックエンド
- Ruby 3.2
- Rails 8
- PostgreSQL
## フロントエンド
- HTML/CSS
- JavaScript
## インフラ・開発環境
- Docker
- Docker Compose
- Render
## 主なライブラリ
- Redcarpet (Markdown変換)
- Rouge　(コードハイライト)

# 主な機能
- ユーザー登録 / ログイン機能
- 記事投稿機能
- Markdown対応
- LaTeX数式表示
- コードハイライト
- タグ機能
- 記事編集・削除
- リアルタイムプレビュー
- 記事検索機能

# 工夫した点
## Markdown + コードハイライト対応
Redcarpet と Rouge を組み合わせ、
Markdown 内のコードブロックにシンタックスハイライトを適用しました。

また、コードのコピー機能も追加し、技術記事としての使いやすさを意識しました。

## Docker を用いた開発環境構築
Docker Compose を用いて Rails / PostgreSQL 環境を構築しました。

開発環境をコンテナ化することで、環境差異を減らし、再現性の高い開発環境を目指しました。

## Render へのデプロイ
Render + PostgreSQL を利用して本番環境へデプロイしました。

デプロイ時には以下の問題が発生し、ログを確認しながら修正を行いました。
- PostgreSQL 接続設定
- assets pipeline のエラー
- credentials / master key の設定
- 本番環境と開発環境の差異
本番環境特有の設定やトラブルシューティングを経験できました。

