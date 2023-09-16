# state: 1
FROM golang:1.21.0-alpine3.18 AS builder

WORKDIR /app
COPY . /app

RUN go mod init main.go && go build -o /app/helloworld

# state: 2
FROM scratch

LABEL key="hellworld"

COPY --from=builder /app/helloworld /app/helloworld

ENTRYPOINT [ "/app/helloworld" ]