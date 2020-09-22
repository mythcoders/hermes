FROM ghcr.io/mythcoders/gaia:latest AS base

ADD Gemfile* $APP_HOME/

RUN echo -e "https://alpine.global.ssl.fastly.net/alpine/v3.10/main\nhttps://alpine.global.ssl.fastly.net/alpine/v3.10/community\n" > /etc/apk/repositories

RUN apk add --no-cache --virtual build-deps build-base && \
  apk add figlet && \
  bundle install && \
  apk del build-deps

COPY package.json yarn.lock $APP_HOME/
RUN yarn install

EXPOSE $APP_PORT

FROM base AS build

ADD . $APP_HOME/

RUN ELASTIC_APM_ENABLED=false ASSETS_PRECOMPILE=1 SECRET_KEY_BASE=1 NODE_ENV=production RAILS_ENV=production \
  bundle exec rake assets:precompile

CMD ["sh", "./scripts/app", "start"]
