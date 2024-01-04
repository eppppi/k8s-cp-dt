FROM golang:1.21.0-alpine

WORKDIR /app
COPY . ./

RUN go mod init example.com/eppppi/k8s-cp-dt/trace-server
RUN go mod tidy
RUN go build -o trace-server

ENTRYPOINT [ "./trace-server" ]

# export port 10039