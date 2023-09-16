# state: 1
# FROM golang:1.21.0-alpine3.18 AS builder
FROM golang:1.21.0 AS builder

WORKDIR /app
COPY . .
RUN go mod init main && go build -o helloworld

# state: 2
FROM scratch

LABEL maintainer="ysucxh@163.com"

WORKDIR /app
COPY --from=builder /app/helloworld helloworld
ENTRYPOINT [ "/app/helloworld" ]