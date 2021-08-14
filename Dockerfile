FROM ghcr.io/mythcoders/gaia:pr-8 AS base

ENV APP_HOME=/opt/hermes
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/

RUN apk add --no-cache --virtual build-deps build-base && \
  apk add vips && \
  bundle install && \
  apk del build-deps

COPY package.json yarn.lock $APP_HOME/
RUN yarn install --frozen-lockfile

EXPOSE 5000

FROM base AS build

ADD . $APP_HOME/

RUN ELASTIC_APM_ENABLED=false ASSETS_PRECOMPILE=1 SECRET_KEY_BASE=1 NODE_ENV=production RAILS_ENV=production \
  bundle exec rake assets:precompile

CMD ["sh", "./scripts/app", "start"]
