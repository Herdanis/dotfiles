FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV TZ=Asia/Jakarta

# Install base packages and tools
RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  wget \
  git \
  ca-certificates \
  build-essential \
  gnupg \
  unzip \
  tar \
  locales \
  tzdata \
  software-properties-common \
  lsb-release \
  && echo "$TZ" > /etc/timezone \
  && ln -sf /usr/share/zoneinfo/$TZ /etc/localtime \
  && dpkg-reconfigure -f noninteractive tzdata \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Go (latest stable)
ENV GO_VERSION=1.22.4
RUN curl -fsSL https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz | tar -C /usr/local -xz
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH=/go
ENV PATH=$GOPATH/bin:$PATH

# Install Neovim (stable)
RUN apt-get update && apt-get install -y --no-install-recommends \
  neovim \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Docker CLI
RUN apt-get update && apt-get install -y --no-install-recommends \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
  && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
  && apt-get update && apt-get install -y --no-install-recommends docker-ce-cli \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Default working directory
WORKDIR /workspace

CMD [ "bash" ]
