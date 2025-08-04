#!/bin/sh

# bundle install を実行
bundle install --deployment --path vendor/bundle --without development test

# データベースのマイグレーションを実行
bundle exec rails db:migrate

# アセットのプリコンパイルを実行
bundle exec rails assets:precompile
