FROM ruby:2.5-alpine

ENV APP_HOME /rorb
ENV BUNDLE_PATH ${APP_HOME}/.rorb_gems

RUN apk add --update --no-cache \
    build-base \ 
    sqlite-dev\ 
    nodejs \
    git \
    tzdata \
    && rm -rf /var/cache/apk/*

RUN mkdir -p ${APP_HOME}
WORKDIR ${APP_HOME}

COPY Gemfile* ${APP_HOME}/

RUN bundle install --jobs=10 --retry=3 --path=${BUNDLE_PATH} --clean \
    && rm -rf /usr/local/bundle/bundler/gems/*/.git /usr/local/bundle/cache/

COPY . ${APP_HOME}

EXPOSE 3000
