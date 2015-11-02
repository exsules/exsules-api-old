FROM alpine:latest
MAINTAINER blazed@darkstar.se

RUN apk --update add \
  ca-certificates \
  ruby \
  ruby-bundler \
  ruby-dev \
  libpq \
  git \
  nodejs && \
  rm -rf /usr/share/ri

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 3 --retry 5

COPY . ./

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]

CMD ["/bin/sh"]