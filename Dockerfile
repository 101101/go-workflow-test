# https://blog.theswarnim.com/getting-started-with-golang-github-action-runners  

FROM golang:1.21.5-alpine3.19 AS builder
WORKDIR /app
COPY . /app
RUN go get -d -v
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o hello-world .

# final stage
FROM alpine:3.19
RUN apk --no-cache add ca-certificates
WORKDIR /app
COPY --from=builder /app/hello-world /app/
CMD sh -c 'pwd; ls -ltrh; ls -ltrh /app; /app/hello-world'
