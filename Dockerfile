FROM ubuntu:latest
COPY alertmanager2hangoutschat /
RUN apt-get update
RUN apt-get install -y ca-certificates
ENTRYPOINT ["/alertmanager2hangoutschat"]
