FROM curlimages/curl:latest as builder

WORKDIR /ss
RUN set -eux; \
    TAG=$(curl -qfL https://api.github.com/repos/shadowsocks/v2ray-plugin/releases/latest | grep tag_name | cut -d '"' -f4); \
    curl -fL -o v2ray-plugin-linux-amd64.tar.gz https://github.com/shadowsocks/v2ray-plugin/releases/download/$TAG/v2ray-plugin-linux-amd64-$TAG.tar.gz
RUN tar xzf v2ray-plugin-linux-amd64.tar.gz
RUN chmod +x v2ray-plugin_linux_amd64

FROM ghcr.io/shadowsocks/ssserver-rust:latest

COPY --from=builder /ss/v2ray-plugin_linux_amd64 /usr/local/bin/v2ray-plugin
