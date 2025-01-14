# Sử dụng Go base image
FROM golang:1.20 AS builder

# Set thư mục làm việc
WORKDIR /app

# Copy file go.mod và go.sum vào container
COPY go.mod ./

# Tải các dependencies
RUN go mod download

# Copy toàn bộ mã nguồn
COPY . .

# Biên dịch mã nguồn
RUN go build -o prometheus_bot

# Tạo một image nhẹ với alpine
FROM alpine:latest

# Set thư mục làm việc
WORKDIR /app

# Copy binary từ builder
COPY --from=builder /app/prometheus_bot .

# Mở port
EXPOSE 9087

# Command chạy ứng dụng
CMD ["./prometheus_bot"]
