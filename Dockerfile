FROM golang:1.16.3 as build

ARG GOPATH=
RUN go env -w GOPROXY=direct
# cache dependencies
ADD go.mod go.sum ./
RUN go mod download
# build
ADD . .
RUN go build -o /ssosync

# copy artifacts to a clean image
FROM amazon/aws-lambda-go:1.2021.04.16.22

RUN yum install -y aws-cli

WORKDIR /var/task

ADD entrypoint.sh .
COPY --from=build /ssosync .
