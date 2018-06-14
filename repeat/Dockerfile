# Don't copy that Dockerfile, use a multi-stage build instead.
FROM golang:1.13.1-alpine3.10

CMD ["/app"]
COPY main.go .
RUN go build -o /app
