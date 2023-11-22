FROM rust:latest as build
LABEL authors="metalface"

COPY . /video-editor-api

WORKDIR /video-editor-api

RUN --mount=type=cache,target=/usr/local/cargo/registry cargo build --release

RUN apt update && apt install -y postgresql-client

RUN apt install -y libpq-dev

RUN cargo install diesel_cli --no-default-features --features postgres

FROM debian:bookworm-slim AS runtime
COPY --from=build /video-editor-api/target/release/video-editor-api /usr/local/bin
WORKDIR /video-editor-api

COPY scripts /scripts
RUN chmod u+x /scripts/*

COPY migrations /migrations

EXPOSE 80
ENTRYPOINT ["/scripts/bootstrap.sh"]