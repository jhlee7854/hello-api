FROM --platform=$BUILDPLATFORM golang:alpine AS build-stage

WORKDIR /build

COPY go.mod ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /build/hello-api

FROM alpine

WORKDIR /app

COPY --from=build-stage /build/hello-api .

EXPOSE 8080

ENTRYPOINT ["/app/hello-api"]
