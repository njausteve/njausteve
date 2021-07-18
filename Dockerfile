FROM elixir:1.11.3-alpine AS build

# Install build dependencies
RUN apk add --no-cache build-base npm git python3

ARG APP_NAME=njausteve
ARG MIX_ENV=prod

# Install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

WORKDIR /opt/app

# Copy the application files into /opt/app
COPY . .

# Compile the application
RUN mix do deps.get, deps.compile, compile

RUN npm --prefix ./assets ci --also=dev --progress=false --no-audit --loglevel=error
RUN npm run --prefix ./assets deploy

# Digest the application
RUN mix phx.digest

# Create the release, and move the artifacts to well-known paths so the
# runtime image doesn't need to know the app name.
# Specifically, the binary is renamed to "server", and
# the entire release is moved into
# /opt/release

RUN mix release \
    && mv _build/${MIX_ENV}/rel/${APP_NAME} /opt/release \
    && mv /opt/release/bin/${APP_NAME} /opt/release/bin/server

# Prepare release image
FROM alpine:3.14 AS app

# Install runtime dependencies
RUN apk add --update --no-cache bash openssl ncurses-libs postgresql-client

ENV MIX_ENV=prod

# Prepare app directory
WORKDIR /opt/app

# Copy release to app container
COPY --from=build /opt/release .

# Copy entrypoint.sh to app container
COPY entrypoint.sh .

EXPOSE 4000

RUN chown -R nobody: /opt/app
USER nobody

ENV HOME=/opt/app

CMD ["bash", "/opt/app/entrypoint.sh"]
