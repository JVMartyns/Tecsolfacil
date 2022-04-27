# base image
# Alpine is a minimal Docker image based on Alpine Linux with a full package index and only 5 MB in size!
FROM elixir:1.13.3-alpine

# putting all project files in the app folder,
# to not mix with container files
WORKDIR /app

# updating and installing development tools package
RUN apk update && apk add --no-cache build-base

# installing elixir package manager
RUN mix local.hex --force && \
    mix local.rebar --force

# copying everything from project root to docker container
COPY . .

# installing dependencies
RUN mix do deps.get, deps.compile

EXPOSE 4000
