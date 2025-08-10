# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.4.2
FROM registry.docker.com/library/ruby:${RUBY_VERSION}-slim AS base

WORKDIR /rails

# bundlerの動作を安定化
ENV BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_JOBS="4" \
    BUNDLE_RETRY="3"

FROM base AS build

# ネイティブ拡張のビルドに必要な依存（pgはlibpq-dev必須）
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential \
      git \
      libpq-dev \
      postgresql-client \
      libyaml-dev \
      libvips \
      pkg-config \
      curl && \
    rm -rf /var/lib/apt/lists/*

# Gemfile.lock のbundlerに合わせる
RUN gem install bundler -v 2.7.1

# 先にGemだけ入れてキャッシュを効かせる
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# アプリ本体
COPY . .

EXPOSE 3000

# 開発用にRailsサーバ起動（RAILS_ENVはcompose側でdevelopmentに）
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
