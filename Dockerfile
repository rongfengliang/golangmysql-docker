# build stage
FROM golang:1.9-alpine AS build-env
RUN apk --no-cache add build-base git bzr mercurial gcc
ENV D=/go/src/github.com/rongfengliang/mysqldemo
ADD . $D
RUN cd $D && ./glide install && go build -o mysqldemo && cp mysqldemo /tmp/

FROM alpine:latest
WORKDIR /app
COPY --from=build-env /tmp/mysqldemo /app/mysqldemo
CMD ["./mysqldemo"]
