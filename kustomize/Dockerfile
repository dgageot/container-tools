FROM gcr.io/cloud-builders/go:alpine as builder
COPY main.go .
RUN go build -o /app

FROM scratch
CMD ["./app"]
COPY --from=builder /app .
