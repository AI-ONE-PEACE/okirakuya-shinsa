#!/bin/sh

# Gemをプロジェクト内の 'vendor/bundle' ディレクトリにインストールします
bundle install --deployment --path vendor/bundle --without development test

# データベースのマイグレーションを実行します
bundle exec rails db:migrate

# アセットのプリコンパイルを実行します
bundle exec rails assets:precompile

# Webサーバーを再起動します
touch tmp/restart.txt
