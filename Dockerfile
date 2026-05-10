# syntax = docker/dockerfile:1

ARG RUBY_VERSION=3.2.11
FROM ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# 必要パッケージ
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      curl \
      libjemalloc2 \
      libvips \
      postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# 本番環境固定
ENV RAILS_ENV=production \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT="development:test"

# ---- build stage ----
FROM base AS build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential \
      git \
      libpq-dev \
      libyaml-dev \
      pkg-config && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# bootsnap
RUN bundle exec bootsnap precompile --gemfile
RUN bundle exec bootsnap precompile app/ lib/


# ---- final stage ----
FROM base

# gemsコピー
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# 非rootユーザー
RUN groupadd -r rails && \
    useradd -r -g rails rails && \
    chown -R rails:rails /rails

USER rails

EXPOSE 3000

# RenderはPORTを渡す
CMD ["bash", "-c", "bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0 -p ${PORT:-3000}"]