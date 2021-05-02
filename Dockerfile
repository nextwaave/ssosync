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
FROM public.ecr.aws/lambda/provided:al2

RUN yum install -y aws-cli golang

ADD bootstrap /var/runtime/

# WORKDIR /var/task
ADD entrypoint.sh /var/task/
COPY --from=build /ssosync /var/task/

CMD [ "/var/task/entrypoint.sh" ]
