#!/usr/bin/env bash
set -euo pipefail

. .env
mix deps.get --only prod
MIX_ENV=prod mix compile --force
MIX_ENV=prod mix assets.deploy
MIX_ENV=prod mix release
