FROM mcr.microsoft.com/devcontainers/base:debian

RUN apt update -y \
    && apt install -y --no-install-recommends shellcheck \
    && rm -rf /var/lib/apt/lists/*  \
    && wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq \
    && chmod +x /usr/local/bin/yq \
    && wget -O /usr/local/bin/semver https://raw.githubusercontent.com/fsaintjacques/semver-tool/master/src/semver \
    && chmod +x /usr/local/bin/semver
