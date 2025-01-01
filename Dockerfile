# Build stage
FROM golang:1.23.4-alpine AS builder

ENV GOPROXY=https://goproxy.io,direct

# ENV GOPROXY=https://goproxy.cn,direct
ENV TZ=Asia/Shanghai

RUN apk update --no-cache && apk add --no-cache tzdata
RUN go install github.com/cortesi/modd/cmd/modd@latest

# Final stage
FROM alpine:latest

RUN apk add --no-cache ca-certificates

WORKDIR /go
COPY --from=builder /go/bin/modd /usr/local/bin/modd

CMD ["modd"]
