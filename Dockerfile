FROM curlimages/curl:latest as builder

ARG V2RAY_PLUGIN_VERSION=1.3.2
WORKDIR /ss
RUN curl -fL -o v2ray-plugin-linux-amd64.tar.gz https://github.com/shadowsocks/v2ray-plugin/releases/download/v${V2RAY_PLUGIN_VERSION}/v2ray-plugin-linux-amd64-v${V2RAY_PLUGIN_VERSION}.tar.gz
RUN tar xzf v2ray-plugin-linux-amd64.tar.gz
RUN chmod +x v2ray-plugin_linux_amd64

FROM ghcr.io/shadowsocks/ssserver-rust:latest

COPY --from=builder /ss/v2ray-plugin_linux_amd64 /usr/local/bin/v2ray-plugin
