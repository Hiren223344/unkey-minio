FROM ghcr.io/unkeyed/unkey-agent:latest

USER root
RUN apt update && apt install -y wget

RUN wget https://dl.min.io/server/minio/release/linux-amd64/minio && \
    chmod +x minio && mv minio /usr/local/bin/minio

WORKDIR /app
COPY . .

EXPOSE 8760 9000

CMD ["bash", "start.sh"]
