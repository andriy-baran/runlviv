# From one of the official ruby images
FROM ruby:2.4.1-alpine

# Available (and reused) args
# Use --build-arg APP_PATH=/usr/app to use another app directory
# Use --build-arg PORT=5000 to use another app default port
ARG APP_PATH='/runlviv'
ARG PORT=3000

# Setting env up
ENV RAILS_ENV='production'
ENV RAKE_ENV='production'

# Installing required packages
RUN apk add --no-cache \
    build-base \
    tzdata \
    git \
    postgresql-dev \
    nodejs \
    imagemagick

# Configuring main directory
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

# Adding gems
COPY Gemfile* ./
RUN bundle install --jobs 20 --retry 5 --without development test

# Adding project files
COPY . ./
RUN bundle exec rake assets:precompile

EXPOSE $PORT
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
