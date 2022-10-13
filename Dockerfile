FROM curlimages/curl:latest as builder

RUN set -eux; \
    curl -L https://github.com/shadowsocks/v2ray-plugin/releases/download/v1.3.2/v2ray-plugin-linux-amd64-v1.3.2.tar.gz | tar xz; \
    mv v2ray-plugin_linux_amd64 /usr/local/bin/v2ray-plugin; \
    chmod +x /usr/local/bin/v2ray-plugin

FROM ghcr.io/shadowsocks/ssserver-rust:latest

COPY --from=builder /usr/local/bin/v2ray-plugin /usr/local/bin/v2ray-plugin
