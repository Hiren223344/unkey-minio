FROM ubuntu:22.04

RUN apt update && apt install -y wget ca-certificates

# Install MinIO
RUN wget -O /usr/local/bin/minio https://dl.min.io/server/minio/release/linux-amd64/minio && \
    chmod +x /usr/local/bin/minio

# Install Unkey
RUN wget -O /usr/local/bin/unkey https://github.com/unkeyed/unkey/releases/download/v2.0.48/unkey-linux-amd64 && \
    chmod +x /usr/local/bin/unkey

WORKDIR /app
COPY . .

EXPOSE 8760 9000

CMD ["bash", "start.sh"]
