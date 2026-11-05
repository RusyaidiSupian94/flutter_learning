FROM mcr.microsoft.com/devcontainers/dotnet:2-10.0

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       git curl ca-certificates unzip xz-utils zip libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter stable SDK
RUN git clone --depth 1 --branch stable \
    https://github.com/flutter/flutter.git /opt/flutter \
    && chown -R vscode:vscode /opt/flutter

ENV PATH="/opt/flutter/bin:${PATH}"

USER vscode

RUN flutter precache --web