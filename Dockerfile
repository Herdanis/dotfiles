FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV TZ=Asia/Jakarta

# Base packages + shell tools
# Note: software-properties-common not in Debian slim, lsb-release added separately
RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  wget \
  git \
  ca-certificates \
  build-essential \
  gnupg \
  unzip \
  tar \
  xz-utils \
  locales \
  tzdata \
  lsb-release \
  fish \
  tmux \
  stow \
  tree \
  ripgrep \
  fd-find \
  bat \
  python3 \
  python3-pip \
  && echo "$TZ" > /etc/timezone \
  && ln -sf /usr/share/zoneinfo/$TZ /etc/localtime \
  && dpkg-reconfigure -f noninteractive tzdata \
  && locale-gen en_US.UTF-8 \
  && ln -sf /usr/bin/fdfind /usr/local/bin/fd \
  && ln -sf /usr/bin/batcat /usr/local/bin/bat \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Go (arch-aware: amd64 or arm64)
ENV GO_VERSION=1.24.3
RUN ARCH=$(dpkg --print-architecture) \
  && curl -fsSL https://golang.org/dl/go${GO_VERSION}.linux-${ARCH}.tar.gz | tar -C /usr/local -xz
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH=/go
ENV PATH="$GOPATH/bin:$PATH"

# Node.js LTS (needed for Neovim LSPs/formatters)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
  && apt-get install -y --no-install-recommends nodejs \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Neovim latest stable (arch-aware: uname returns aarch64 but nvim uses arm64)
RUN ARCH=$(uname -m | sed 's/aarch64/arm64/') \
  && curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${ARCH}.tar.gz" \
  | tar -C /usr/local -xz --strip-components=1

# Starship prompt (install script detects arch)
RUN curl -fsSL https://starship.rs/install.sh | sh -s -- --yes

# FZF (built from source, no arch issue)
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /opt/fzf \
  && /opt/fzf/install --bin \
  && ln -sf /opt/fzf/bin/fzf /usr/local/bin/fzf

# Zoxide (install script detects arch)
RUN curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh \
  && mv /root/.local/bin/zoxide /usr/local/bin/zoxide

# Lazygit (arch-aware: x86_64 or arm64)
RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
    | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/') \
  && ARCH=$(uname -m | sed 's/aarch64/arm64/') \
  && curl -fsSL "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_${ARCH}.tar.gz" \
  | tar -xz -C /usr/local/bin lazygit

# Docker CLI (arch-aware)
RUN ARCH=$(dpkg --print-architecture) \
  && curl -fsSL https://download.docker.com/linux/debian/gpg \
    | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
  && echo "deb [arch=${ARCH} signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    > /etc/apt/sources.list.d/docker.list \
  && apt-get update && apt-get install -y --no-install-recommends docker-ce-cli \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Deploy dotfiles with Stow
COPY . /root/.dotfiles/
RUN mkdir -p /root/.config \
  && cd /root/.dotfiles \
  && stow .

# Patch config.fish: make brew optional (no Homebrew on Linux)
RUN sed -i 's@/opt/homebrew/bin/brew shellenv | source@command -q brew; and brew shellenv | source@' \
  /root/.config/fish/config.fish

# Remove macOS-only PATH entries (lm-studio, opencode, agent-view)
RUN sed -i '/lm-studio\/bin/d; /\.opencode\/bin/d; /\.agent-view\/bin/d' \
  /root/.config/fish/config.fish

# Patch tmux.conf: fix hardcoded Homebrew fish path
RUN sed -i 's@/opt/homebrew/bin/fish@/usr/bin/fish@g' \
  /root/.config/tmux/tmux.conf

# Install TPM (tmux plugin manager)
RUN git clone --depth 1 https://github.com/tmux-plugins/tpm \
  /root/.config/tmux/plugins/tpm

# Install tmux plugins headlessly
RUN tmux new-session -d -s install \
  && /root/.config/tmux/plugins/tpm/bin/install_plugins \
  && tmux kill-session -t install || true

# Set Fish as default shell
RUN chsh -s /usr/bin/fish

# Pre-install Neovim plugins
RUN nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

WORKDIR /workspace

CMD ["fish"]
