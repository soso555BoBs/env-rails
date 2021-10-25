FROM ruby:2.7.4

# timezone environment
ENV TZ=Asia/Tokyo \
  # locale
  LANG=ja_JP.UTF-8 \
  LANGUAGE=ja_JP:ja \
  LC_ALL=ja_JP.UTF-8

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       postgresql-client \
                       yarn \
                       git \
                       libicu-dev \
                       libonig-dev \
                       libzip-dev \
                       unzip \
                       locales \
                       curl \
                       vim

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    locale-gen ja_JP.UTF-8 && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

ENV APP_ROOT /work/backend
WORKDIR $APP_ROOT
COPY ./infra/docker/ruby/Gemfile $APP_ROOT/Gemfile
COPY ./infra/docker/ruby/Gemfile.lock $APP_ROOT/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY ./infra/docker/ruby/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
