#!/bin/bash
set -o errexit -o pipefail -o nounset
cd "$(dirname "$0")"

echo 'INITIALIZE VOLUME TARGETS'
rm -rf pnpm-store node_modules
mkdir pnpm-store node_modules

echo 'BUILD THE IMAGE'
podman build . -v "$(pwd)/pnpm-store:/pnpm-store" -v "$(pwd)/node_modules:/app/node_modules" --tag test-pnpm-container:latest

echo 'RUN THE IMAGE'
podman run test-pnpm-container:latest pnpm install
