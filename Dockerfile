# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.3.0
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /enumeratorr

# Set development environment
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle"

# Install system packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev net-tools

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

# Enable hot reloading with Webpacker or Vite (if used)
RUN mkdir -p tmp/pids && rm -f tmp/pids/server.pid

# Run as non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails /enumeratorr
USER rails:rails

# Expose port 3003
EXPOSE 3003

# Start the Rails server for development
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails server -b 0.0.0.0 -p 3003"]