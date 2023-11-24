FROM mcr.microsoft.com/devcontainers/base:debian

RUN apt update -y \
    && apt install -y --no-install-recommends shellcheck \
    && rm -rf /var/lib/apt/lists/*  \
    && wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq &&\
    chmod +x /usr/local/bin/yq