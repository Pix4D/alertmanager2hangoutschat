FROM golang:1.13-alpine as builder
ENV GOPATH=/root/go
#
# Optimize downloading of dependencies only when they are needed.
# This requires to _first_ copy only these two files, run `go mod download`,
# and _then_ copy the rest of the source code.
#
COPY go.mod go.sum ./
RUN go mod download

COPY main.go .
RUN CGO_ENABLED=0 go build -o /alertmanager2hangoutschat

FROM alpine
RUN apk --no-cache add ca-certificates
COPY --from=builder /alertmanager2hangoutschat /alertmanager2hangoutschat
ENTRYPOINT ["/alertmanager2hangoutschat"]
