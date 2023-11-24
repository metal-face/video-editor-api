FROM rust:latest as build
LABEL authors="metalface"

WORKDIR /video-editor-api
COPY . /video-editor-api
RUN --mount=type=cache,target=/usr/local/cargo/registry cargo build --release


FROM ubuntu:latest AS runtime
WORKDIR /video-editor-api

COPY scripts /scripts
RUN chmod u+x /scripts/*

COPY migrations /migrations

RUN apt update && apt install -y postgresql-client
RUN apt install -y libpq-dev

COPY --from=build /video-editor-api/target/release/video-editor-api /usr/local/bin
ENTRYPOINT ["/scripts/bootstrap.sh"]