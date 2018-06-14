FROM gcr.io/cloud-builders/go as builder
WORKDIR /app
COPY . ./
RUN go build -mod=vendor -o /proxy

FROM alpine
EXPOSE 8888
ENTRYPOINT ["/proxy"]
COPY --from=builder /proxy /
