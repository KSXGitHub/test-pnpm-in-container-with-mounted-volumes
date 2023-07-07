FROM ubuntu:latest

RUN apt update -y
RUN apt install -y curl
RUN apt install -y nodejs
RUN curl -fsSL https://get.pnpm.io/install.sh | bash -
ENV PATH "/root/.local/share/pnpm:${PATH}"
VOLUME [ "/pnpm-store", "/app/node_modules" ]
RUN pnpm config --global set store-dir /pnpm-store
COPY package.json /app/package.json
WORKDIR /app
