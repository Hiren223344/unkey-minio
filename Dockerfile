FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    bash \
    jq \
    nano \
    wget \
    && rm -rf /var/lib/apt/lists/*

# -------------------------
# Install MinIO
# -------------------------
RUN wget -O /usr/local/bin/minio https://dl.min.io/server/minio/release/linux-amd64/minio && \
    chmod +x /usr/local/bin/minio

# -------------------------
# Install Unkey CLI (Official Installer)
# -------------------------
RUN curl -fsSL https://cli.unkey.dev | bash

# Put unkey in PATH
RUN mv /root/.unkey/bin/unkey /usr/local/bin/unkey && \
    chmod +x /usr/local/bin/unkey

# -------------------------
# Storage
# -------------------------
RUN mkdir -p /data

# -------------------------
# Ports
# -------------------------
EXPOSE 9000
EXPOSE 9001
EXPOSE 3000

# -------------------------
# MinIO creds
# -------------------------
ENV MINIO_ROOT_USER=unkey
ENV MINIO_ROOT_PASSWORD=unkey123

# -------------------------
# Start
# -------------------------
CMD bash -c "\
minio server /data --console-address :9001 & \
sleep 4 && \
unkey server \
"
