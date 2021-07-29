FROM ruby:2.6.5

ENV RAILS_ENV=production

# 必要なパッケージのインストール
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn           

WORKDIR /app
COPY ./src /app
RUN bundle config --local set path 'vendor/bundle' \
    && bundle install

#dockerにコピー
COPY start.sh /start.sh
#changemode(chmod)で権限付与 
RUN chmod 744 /start.sh
#実行コマンド設定
CMD ["sh", "/start.sh"]