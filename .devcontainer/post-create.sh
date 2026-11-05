#!/bin/bash

set -e

echo "Starting report_app Web setup..."

# Git LFS
git lfs install

# Flutter
flutter --version

if [ -f "app/pubspec.yaml" ]; then
    echo "Installing Flutter packages..."

    cd app
    flutter pub get
    cd ..
fi

# .NET
dotnet --version

if [ -d "api" ]; then

    API_PROJECT=$(find api -maxdepth 3 -name "*.csproj" -print -quit)

    if [ -n "$API_PROJECT" ]; then
        dotnet restore "$API_PROJECT"
    fi

fi

# PostgreSQL client
psql --version

echo "Web development environment ready!"