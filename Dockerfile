FROM golang:1.21.6-alpine3.19 AS build-stage

WORKDIR /build

COPY go.mod ./
RUN go mod download

COPY *.go ./

# RUN go build -o /build/hello-api
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -ldflags '-s' -o /build/hello-api .

FROM scratch

WORKDIR /app

COPY --from=build-stage /build/hello-api .

EXPOSE 8080

ENTRYPOINT ["/app/hello-api"]
