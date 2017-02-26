FROM busbyjon/armv6-ruby:2.4

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        arp-scan \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .

RUN bin/rake assets:precompile

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

