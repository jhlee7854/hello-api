FROM --platform=$BUILDPLATFORM golang:1.21-alpine AS build
ARG TARGETOS
ARG TARGETARCH

WORKDIR /build

COPY go.mod ./
RUN go mod download
COPY *.go ./

RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /build/hello-api

FROM alpine
WORKDIR /app

COPY --from=build /build/hello-api .

EXPOSE 8080

ENTRYPOINT ["/app/hello-api"]
