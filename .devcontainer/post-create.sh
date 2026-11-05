#!/usr/bin/env bash
set -euo pipefail

echo "Checking .NET..."
dotnet --version

echo "Checking Flutter..."
flutter --version

echo "Restoring .NET dependencies..."
while IFS= read -r -d '' project; do
  dotnet restore "$project"
done < <(find api -type f -name '*.csproj' -print0)

echo "Restoring Flutter dependencies..."
if [ -f app/pubspec.yaml ]; then
  cd app
  flutter pub get
fi

set -e

sudo apt-get update
sudo apt-get install -y git-lfs
git lfs install

echo "Setup completed."