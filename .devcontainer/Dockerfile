FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_NOLOGO=1

# Install development dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    zip \
    git \
    git-lfs \
    jq \
    ca-certificates \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Install .NET 10
RUN apt-get update && apt-get install -y dotnet-sdk-10.0 \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter stable
RUN git clone --depth 1 --branch stable \
    https://github.com/flutter/flutter.git /opt/flutter

ENV FLUTTER_HOME=/opt/flutter
ENV PATH="${FLUTTER_HOME}/bin:${PATH}"

# Enable Flutter Web
RUN git config --system --add safe.directory /opt/flutter \
    && flutter config --no-analytics \
    && flutter config --enable-web \
    && flutter precache --web

RUN chown -R vscode:vscode /opt/flutter

