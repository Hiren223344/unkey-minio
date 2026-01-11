FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Base tools
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    ca-certificates \
    bash \
    jq \
    nano \
    && rm -rf /var/lib/apt/lists/*

# ----------------------------
# Install MinIO
# ----------------------------
RUN wget -O /usr/local/bin/minio https://dl.min.io/server/minio/release/linux-amd64/minio && \
    chmod +x /usr/local/bin/minio

# ----------------------------
# Install Unkey CLI (FIXED VERSION)
# ----------------------------
RUN wget -O /usr/local/bin/unkey https://github.com/unkeyed/unkey/releases/download/v1.5.20/unkey_linux_amd64 && \
    chmod +x /usr/local/bin/unkey

# ----------------------------
# Create storage
# ----------------------------
RUN mkdir -p /data

# ----------------------------
# Ports
# ----------------------------
EXPOSE 9000
EXPOSE 9001
EXPOSE 3000

# ----------------------------
# MinIO credentials
# ----------------------------
ENV MINIO_ROOT_USER=unkey
ENV MINIO_ROOT_PASSWORD=unkey123

# ----------------------------
# Startup
# ----------------------------
CMD bash -c "\
minio server /data --console-address :9001 & \
sleep 4 && \
unkey server \
"
