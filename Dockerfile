
FROM golang:1.25 AS builder 

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o app-binary .

FROM scratch

WORKDIR /

COPY --from=builder /app/app-binary .

COPY --from=builder /app/tracker.db .

CMD ["./app-binary"]