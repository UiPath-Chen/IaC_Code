FROM golang:1.17

WORKDIR /opt/app
COPY . .
RUN go mod init main.go && go mod tidy && go build -o example
ENTRYPOINT [ "/opt/app/example" ]
CMD [ "run", "/bin/bash" ]