FROM golang:1.13.1-alpine3.10 as builder
COPY main.go .
RUN go build -o /app

FROM alpine:3.10
CMD ["./app"]
COPY --from=builder /app .
