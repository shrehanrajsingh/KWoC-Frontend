#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if [[ ! -f .env ]]; then
  if [[ -f .env.template ]]; then
    cp .env.template .env
    echo "Created .env from .env.template — fill in values if needed."
  else
    echo "Missing .env (and no .env.template). Aborting." >&2
    exit 1
  fi
fi

if ! command -v pnpm >/dev/null 2>&1; then
  echo "pnpm is required. Install it from https://pnpm.io/installation" >&2
  exit 1
fi

if [[ ! -d node_modules ]]; then
  echo "Installing dependencies..."
  pnpm install
fi

echo "Starting KWoC Frontend..."
exec pnpm run dev "$@"
