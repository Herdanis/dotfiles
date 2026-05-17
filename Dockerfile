FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV TZ=Asia/Jakarta

# ============================================
# Base System Packages
# ============================================
# software-properties-common absent in Debian slim; lsb-release added separately
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

# ============================================
# Go
# ============================================
ENV GO_VERSION=1.24.3
RUN ARCH=$(dpkg --print-architecture) \
  && curl -fsSL https://golang.org/dl/go${GO_VERSION}.linux-${ARCH}.tar.gz | tar -C /usr/local -xz
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH=/go
ENV PATH="$GOPATH/bin:$PATH"

# ============================================
# Node.js LTS
# ============================================
# Required for Neovim LSPs and formatters
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
  && apt-get install -y --no-install-recommends nodejs \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# ============================================
# Neovim
# ============================================
# apt neovim is outdated; pull latest from GitHub releases
# uname returns aarch64 but nvim assets use arm64
RUN ARCH=$(uname -m | sed 's/aarch64/arm64/') \
  && curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${ARCH}.tar.gz" \
  | tar -C /usr/local -xz --strip-components=1

# ============================================
# CLI Tools
# ============================================
# Starship: install script auto-detects arch
RUN curl -fsSL https://starship.rs/install.sh | sh -s -- --yes

# FZF: built from source, no arch mapping needed
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /opt/fzf \
  && /opt/fzf/install --bin \
  && ln -sf /opt/fzf/bin/fzf /usr/local/bin/fzf

# Zoxide: install script auto-detects arch
RUN curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh \
  && mv /root/.local/bin/zoxide /usr/local/bin/zoxide

# Lazygit: arch-aware (x86_64 or arm64)
RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
    | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/') \
  && ARCH=$(uname -m | sed 's/aarch64/arm64/') \
  && curl -fsSL "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_${ARCH}.tar.gz" \
  | tar -xz -C /usr/local/bin lazygit

# Yazi: arch uses uname -m directly (x86_64 or aarch64); ships yazi + ya binaries
RUN ARCH=$(uname -m) \
  && curl -fsSL "https://github.com/sxyazi/yazi/releases/latest/download/yazi-${ARCH}-unknown-linux-gnu.zip" \
    -o /tmp/yazi.zip \
  && unzip -q /tmp/yazi.zip -d /tmp/yazi \
  && mv /tmp/yazi/yazi-${ARCH}-unknown-linux-gnu/yazi /usr/local/bin/yazi \
  && mv /tmp/yazi/yazi-${ARCH}-unknown-linux-gnu/ya /usr/local/bin/ya \
  && rm -rf /tmp/yazi /tmp/yazi.zip

# ============================================
# Docker CLI
# ============================================
RUN ARCH=$(dpkg --print-architecture) \
  && curl -fsSL https://download.docker.com/linux/debian/gpg \
    | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
  && echo "deb [arch=${ARCH} signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    > /etc/apt/sources.list.d/docker.list \
  && apt-get update && apt-get install -y --no-install-recommends docker-ce-cli \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# ============================================
# Deploy Dotfiles
# ============================================
ARG DOTFILES_REPO=https://github.com/Herdanis/dotfiles.git
ARG DOTFILES_BRANCH=main
RUN git clone --depth 1 --branch ${DOTFILES_BRANCH} ${DOTFILES_REPO} /root/.dotfiles \
  && mkdir -p /root/.config \
  && cd /root/.dotfiles \
  && stow .

# ============================================
# Linux Compatibility Patches
# ============================================
# Homebrew is macOS-only; make brew sourcing a no-op when absent
RUN sed -i 's@/opt/homebrew/bin/brew shellenv | source@command -q brew; and brew shellenv | source@' \
  /root/.config/fish/config.fish

# Strip macOS-only PATH entries (lm-studio, opencode, agent-view)
RUN sed -i '/lm-studio\/bin/d; /\.opencode\/bin/d; /\.agent-view\/bin/d' \
  /root/.config/fish/config.fish

# Homebrew ships fish at /opt/homebrew/bin/fish; Linux uses /usr/bin/fish
RUN sed -i 's@/opt/homebrew/bin/fish@/usr/bin/fish@g' \
  /root/.config/tmux/tmux.conf

# ============================================
# Plugin Setup
# ============================================
# TPM (Tmux Plugin Manager)
RUN git clone --depth 1 https://github.com/tmux-plugins/tpm \
  /root/.config/tmux/plugins/tpm

# Install tmux plugins headlessly
RUN tmux new-session -d -s install \
  && /root/.config/tmux/plugins/tpm/bin/install_plugins \
  && tmux kill-session -t install || true

# Pre-install Neovim plugins
RUN nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

# ============================================
# Final Configuration
# ============================================
RUN chsh -s /usr/bin/fish

WORKDIR /workspace

CMD ["fish"]
