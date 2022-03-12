FROM ruby:3.0.1-alpine AS base

ENV APP_HOME=/opt/hermes \
  GEM_HOME=/usr/local/bundle \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3 \
  LANG=en_US.UTF-8 \
  PATH=$GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH \
  PATH=/root/.yarn/bin:$PATH

RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
COPY package.json yarn.lock $APP_HOME/

# Install packages
RUN apk update && \
  apk --no-cache add \
  alpine-sdk \
  build-base \
  coreutils \
  libcurl \
  nodejs \
  postgresql-dev \
  tzdata \
  less \
  git \
  vips

# Set local timezone
RUN cp /usr/share/zoneinfo/US/Eastern /etc/localtime && \
  echo "US/Eastern" > /etc/timezone

# Install yarn
RUN apk add --virtual build-yarn curl gnupg && \
  touch ~/.bashrc && \
  curl -o- -L https://yarnpkg.com/install.sh | sh -s -- --version 1.22.10 && \
  apk del build-yarn gnupg

# Upgrade RubyGems and install required Bundler version
RUN gem update --system && gem install bundler -v 2.2.24

RUN bundle install
RUN yarn install --frozen-lockfile

EXPOSE 5000

FROM base AS build

ADD . $APP_HOME/

RUN ASSETS_PRECOMPILE=1 SECRET_KEY_BASE=1 NODE_ENV=production RAILS_ENV=production \
  bundle exec rake assets:precompile

CMD ["sh", "./scripts/app", "start"]
