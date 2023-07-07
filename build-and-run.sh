#!/bin/bash
set -o errexit -o pipefail -o nounset
cd "$(dirname "$0")"

echo 'INITIALIZE VOLUME TARGETS'
rm -rf pnpm-store node_modules
mkdir pnpm-store node_modules

echo 'BUILD THE IMAGE'
podman build . --tag test-pnpm-container

echo 'RUN THE IMAGE'
podman run -v "$(pwd)/pnpm-store:/pnpm-store" -v "$(pwd)/node_modules:/app/node_modules" -it test-pnpm-container:latest bash -c 'pnpm install && bash -i'
