FROM mcr.microsoft.com/devcontainers/base:debian

RUN apt update -y \
    && apt install -y --no-install-recommends shellcheck \
    && rm -rf /var/lib/apt/lists/* 