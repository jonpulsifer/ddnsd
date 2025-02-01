FROM golang:1.23-alpine AS builder

WORKDIR /app
COPY go.mod go.sum main.go ./
RUN go mod download
RUN CGO_ENABLED=0 go build -o ddnsd main.go

FROM alpine:latest
COPY --from=builder /app/ddnsd /usr/local/bin/ddnsd
CMD ["/usr/local/bin/ddnsd"]
