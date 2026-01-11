FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install base tools
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    ca-certificates \
    bash \
    nano \
    unzip \
    jq \
    && rm -rf /var/lib/apt/lists/*

# ----------------------------
# Install MinIO
# ----------------------------
RUN wget -O /usr/local/bin/minio https://dl.min.io/server/minio/release/linux-amd64/minio && \
    chmod +x /usr/local/bin/minio

# ----------------------------
# Install Unkey CLI (Correct way)
# ----------------------------
RUN wget -O /usr/local/bin/unkey https://github.com/unkeyed/unkey/releases/latest/download/unkey_linux_amd64 && \
    chmod +x /usr/local/bin/unkey

# ----------------------------
# Create folders
# ----------------------------
RUN mkdir -p /data /config

# ----------------------------
# Expose ports
# ----------------------------
# 9000 → MinIO
# 9001 → MinIO Console
# 3000 → Your API / Unkey Agent
EXPOSE 9000
EXPOSE 9001
EXPOSE 3000

# ----------------------------
# Default credentials (change in prod)
# ----------------------------
ENV MINIO_ROOT_USER=unkey
ENV MINIO_ROOT_PASSWORD=unkey123

# ----------------------------
# Start everything
# ----------------------------
CMD bash -c "\
minio server /data --console-address :9001 & \
sleep 5 && \
unkey server \
"
