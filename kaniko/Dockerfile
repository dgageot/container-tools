FROM golang:1.13.0-alpine3.10 as builder
COPY main.go .
RUN go build -o /app
CMD ["/app"]
