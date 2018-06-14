FROM gcr.io/cloud-builders/go as builder
WORKDIR /app
COPY . ./
RUN go build -mod=vendor -o /ref

FROM alpine
EXPOSE 8888
ENTRYPOINT ["/ref"]
COPY --from=builder /ref /
