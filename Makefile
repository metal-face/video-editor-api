#!/usr/bin/env make

build:
	docker build -t video-editor-api:latest .

run-api:
	docker run \
		--env APP_COMPONENT=api \
		--env APP_PORT=8080 \
		--env-file=.env \
		-it video-editor-api:latest

run-api-bg:
	docker run \
		--env APP_COMPONENT=api \
		--env APP_PORT=8080 \
		--env-file=.env \
		-d video-editor-api:latest
