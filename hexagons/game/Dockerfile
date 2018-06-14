FROM gcr.io/cloud-builders/go as builder
WORKDIR /app
COPY . ./
RUN go build -mod=vendor -o /game

FROM alpine
EXPOSE 8888
ENTRYPOINT ["/game"]
COPY --from=builder /game /
