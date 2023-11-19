FROM rust:latest as build
LABEL authors="metalface"

RUN cargo new --lib /video-editor-api
COPY Cargo.toml Cargo.lock /video-editor-api/

WORKDIR /video-editor-api
RUN --mount=type=cache,target=/usr/local/cargo/registry cargo build --release

COPY . /video-editor-api

RUN --mount=type=cache,target=/usr/local/cargo/registry <<EOF
    set -e
    touch /video-editor-api/src/main.rs
    cargo build --release
EOF

FROM debian:bookworm-slim AS runtime
WORKDIR /video-editor-api

COPY scripts /scripts
COPY migrations /migrations

COPY --from=build /video-editor-api/target/release/video-editor-api /usr/local/bin
CMD ["/scripts/bootstrap.sh"]