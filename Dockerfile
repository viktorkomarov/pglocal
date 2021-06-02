FROM golang:1.16 as go

RUN go get -u github.com/pressly/goose/cmd/goose

FROM postgres:13.3

COPY migrations /migrations
COPY --from=go /go/bin/goose /bin/

RUN echo 'goose -dir /migrations postgres ADDRESS up' > /docker-entrypoint-initdb.d/migrate.sh && \
    chmod +x /docker-entrypoint-initdb.d/migrate.sh
