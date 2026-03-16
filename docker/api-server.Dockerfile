# Stage 1: Build
FROM golang:1.23-alpine AS builder
WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o api-server ./cmd/server

# Stage 2: Runtime
FROM alpine:3.21
COPY --from=builder /build/api-server /api-server
EXPOSE 8080
ENTRYPOINT ["/api-server"]
