#!/bin/bash
set -euo pipefail

# Only run in Claude Code remote (web) environment
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Install gh CLI if not already installed
if ! command -v gh &>/dev/null; then
  GH_VERSION="2.86.0"
  TARBALL="gh_${GH_VERSION}_linux_amd64.tar.gz"
  URL="https://github.com/cli/cli/releases/download/v${GH_VERSION}/${TARBALL}"

  curl -sL "$URL" -o "/tmp/${TARBALL}"
  tar -xzf "/tmp/${TARBALL}" -C /tmp
  cp "/tmp/gh_${GH_VERSION}_linux_amd64/bin/gh" /usr/local/bin/gh
  rm -rf "/tmp/${TARBALL}" "/tmp/gh_${GH_VERSION}_linux_amd64"
fi

# If GH_TOKEN is set, persist it for the session
if [ -n "${GH_TOKEN:-}" ]; then
  echo "export GH_TOKEN=\"${GH_TOKEN}\"" >> "$CLAUDE_ENV_FILE"
fi
