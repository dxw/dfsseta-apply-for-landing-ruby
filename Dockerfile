# ------------------------------------------------------------------------------
# Base
# ------------------------------------------------------------------------------
FROM ruby:3.2.2 as base
RUN date +"==> TIME MM:SS = %M:%S"
LABEL org.opencontainers.image.authors="contact@dxw.com"

RUN date +"==> TIME MM:SS = %M:%S"
RUN curl -L https://deb.nodesource.com/setup_16.x | bash -
RUN date +"==> TIME MM:SS = %M:%S"
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN date +"==> TIME MM:SS = %M:%S"
RUN \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
  tee /etc/apt/sources.list.d/yarn.list

RUN date +"==> TIME MM:SS = %M:%S"
RUN \
  apt-get update && \
  apt-get install -y --fix-missing --no-install-recommends \
  build-essential \
  libpq-dev \
  nodejs \
  yarn

RUN date +"==> TIME MM:SS = %M:%S"
ENV APP_HOME /srv/app
RUN date +"==> TIME MM:SS = %M:%S"
ENV DEPS_HOME /deps

RUN date +"==> TIME MM:SS = %M:%S"
ARG RAILS_ENV
RUN date +"==> TIME MM:SS = %M:%S"
ENV RAILS_ENV ${RAILS_ENV:-production}
RUN date +"==> TIME MM:SS = %M:%S"
ENV NODE_ENV ${RAILS_ENV:-production}
RUN date +"==> TIME MM:SS = %M:%S"

# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------
FROM base AS dependencies

RUN date +"==> TIME MM:SS = %M:%S"
RUN apt-get update && apt-get install -y yarn

RUN date +"==> TIME MM:SS = %M:%S"
WORKDIR ${DEPS_HOME}

# Install Ruby dependencies
RUN date +"==> TIME MM:SS = %M:%S"
ENV BUNDLE_GEM_GROUPS ${RAILS_ENV}

RUN date +"==> TIME MM:SS = %M:%S"
COPY Gemfile ${DEPS_HOME}/Gemfile
RUN date +"==> TIME MM:SS = %M:%S"
COPY Gemfile.lock ${DEPS_HOME}/Gemfile.lock

RUN date +"==> TIME MM:SS = %M:%S"
RUN gem update --system 3.3.5
RUN date +"==> TIME MM:SS = %M:%S"
RUN gem install bundler -v 2.3.5
RUN date +"==> TIME MM:SS = %M:%S"
RUN bundle config set frozen "true"
RUN date +"==> TIME MM:SS = %M:%S"
RUN bundle config set no-cache "true"
RUN date +"==> TIME MM:SS = %M:%S"
RUN bundle config set with "${BUNDLE_GEM_GROUPS}"
RUN date +"==> TIME MM:SS = %M:%S"
RUN bundle install --retry=10 --jobs=4
# End

# Install Javascript dependencies
RUN date +"==> TIME MM:SS = %M:%S"
COPY yarn.lock ${DEPS_HOME}/yarn.lock
RUN date +"==> TIME MM:SS = %M:%S"
COPY package.json ${DEPS_HOME}/package.json
RUN date +"==> TIME MM:SS = %M:%S"
COPY rollup.config.js ${DEPS_HOME}/rollup.config.js

RUN date +"==> TIME MM:SS = %M:%S"
RUN \
  if [ ${RAILS_ENV} = "production" ]; then \
  yarn install --frozen-lockfile --production; \
  else \
  yarn install --frozen-lockfile; \
  fi
# End
RUN date +"==> TIME MM:SS = %M:%S"

# ------------------------------------------------------------------------------
# Web
# ------------------------------------------------------------------------------
FROM base AS web

RUN date +"==> TIME MM:SS = %M:%S"
WORKDIR ${APP_HOME}

# Copy dependencies (relying on dependencies using the same base image as this)
RUN date +"==> TIME MM:SS = %M:%S"
COPY --from=dependencies ${GEM_HOME} ${GEM_HOME}
RUN date +"==> TIME MM:SS = %M:%S"
COPY --from=dependencies ${DEPS_HOME}/node_modules ${APP_HOME}/node_modules
# End

# Copy app code (sorted by vague frequency of change for caching)
RUN date +"==> TIME MM:SS = %M:%S"
RUN mkdir -p ${APP_HOME}/log
RUN date +"==> TIME MM:SS = %M:%S"
RUN mkdir -p ${APP_HOME}/tmp

RUN date +"==> TIME MM:SS = %M:%S"
COPY Gemfile ${APP_HOME}/Gemfile
RUN date +"==> TIME MM:SS = %M:%S"
COPY Gemfile.lock ${APP_HOME}/Gemfile.lock
RUN date +"==> TIME MM:SS = %M:%S"
COPY package.json ${APP_HOME}/package.json
RUN date +"==> TIME MM:SS = %M:%S"
COPY yarn.lock ${APP_HOME}/yarn.lock
RUN date +"==> TIME MM:SS = %M:%S"
COPY rollup.config.js ${APP_HOME}/rollup.config.js
RUN date +"==> TIME MM:SS = %M:%S"
COPY config.ru ${APP_HOME}/config.ru
RUN date +"==> TIME MM:SS = %M:%S"
COPY Rakefile ${APP_HOME}/Rakefile
RUN date +"==> TIME MM:SS = %M:%S"
COPY script ${APP_HOME}/script
RUN date +"==> TIME MM:SS = %M:%S"
COPY public ${APP_HOME}/public
RUN date +"==> TIME MM:SS = %M:%S"
COPY vendor ${APP_HOME}/vendor
RUN date +"==> TIME MM:SS = %M:%S"
COPY bin ${APP_HOME}/bin
RUN date +"==> TIME MM:SS = %M:%S"
COPY config ${APP_HOME}/config
RUN date +"==> TIME MM:SS = %M:%S"
COPY lib ${APP_HOME}/lib
RUN date +"==> TIME MM:SS = %M:%S"
COPY db ${APP_HOME}/db
RUN date +"==> TIME MM:SS = %M:%S"
COPY app ${APP_HOME}/app
# End

# Create tmp/pids
RUN date +"==> TIME MM:SS = %M:%S"
RUN mkdir -p tmp/pids

RUN date +"==> TIME MM:SS = %M:%S"
RUN SECRET_KEY_BASE="secret" bundle exec rake assets:precompile

# TODO:
# In order to expose the current git sha & time of build in the /healthcheck
# endpoint, pass these values into your deployment script, for example:
# --build-arg CURRENT_GIT_SHA="$GITHUB_SHA" \
# --build-arg TIME_OF_BUILD="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
RUN date +"==> TIME MM:SS = %M:%S"
ARG CURRENT_GIT_SHA
RUN date +"==> TIME MM:SS = %M:%S"
ARG TIME_OF_BUILD

RUN date +"==> TIME MM:SS = %M:%S"
ENV CURRENT_GIT_SHA ${CURRENT_GIT_SHA}
RUN date +"==> TIME MM:SS = %M:%S"
ENV TIME_OF_BUILD ${TIME_OF_BUILD}

RUN date +"==> TIME MM:SS = %M:%S"
COPY ./docker-entrypoint.sh /
RUN date +"==> TIME MM:SS = %M:%S"
RUN chmod +x /docker-entrypoint.sh
RUN date +"==> TIME MM:SS = %M:%S"
ENTRYPOINT ["/docker-entrypoint.sh"]

RUN date +"==> TIME MM:SS = %M:%S"
EXPOSE 3000

RUN date +"==> TIME MM:SS = %M:%S"
CMD bin/rails server -p 3000 -b '0.0.0.0'
RUN date +"==> TIME MM:SS = %M:%S"

# ------------------------------------------------------------------------------
# Test
# ------------------------------------------------------------------------------
FROM web as test

RUN date +"==> TIME MM:SS = %M:%S"
RUN \
  apt-get update && \
  apt-get install -y \
  shellcheck \
  yarn

RUN date +"==> TIME MM:SS = %M:%S"
COPY .eslintignore ${APP_HOME}/.eslintignore
RUN date +"==> TIME MM:SS = %M:%S"
COPY .eslintrc.json ${APP_HOME}/.eslintrc.json
RUN date +"==> TIME MM:SS = %M:%S"
COPY .prettierignore ${APP_HOME}/.prettierignore
RUN date +"==> TIME MM:SS = %M:%S"
COPY .prettierrc ${APP_HOME}/.prettierrc
RUN date +"==> TIME MM:SS = %M:%S"
COPY .stylelintrc.json ${APP_HOME}/.stylelintrc.json
RUN date +"==> TIME MM:SS = %M:%S"
COPY .stylelintignore ${APP_HOME}/.stylelintignore

RUN date +"==> TIME MM:SS = %M:%S"
COPY .rspec ${APP_HOME}/.rspec
RUN date +"==> TIME MM:SS = %M:%S"
COPY spec ${APP_HOME}/spec
RUN date +"==> TIME MM:SS = %M:%S"
