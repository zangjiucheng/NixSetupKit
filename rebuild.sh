#!/bin/sh
set -eu

SYSTEM="$(uname -s)"

if [ "$SYSTEM" = "Darwin" ]; then
  CONFIGURATION="${1:-macos}"
  REBUILD="darwin-rebuild"
  SUDO=""
else
  CONFIGURATION="${1:-nixos}"
  REBUILD="nixos-rebuild"
  SUDO="sudo"
fi

GITBRANCH="${2:-build}"

git switch --quiet --merge "$GITBRANCH"

if ! git diff --quiet --no-ext-diff; then
  git commit --quiet --all --message '_'
fi

if git diff --quiet --no-ext-diff main; then
  exit 0
fi

rm -f result

if ! $SUDO "$REBUILD" switch --show-trace \
  --flake ".#${CONFIGURATION}" \
  >/dev/null; then
  exit 1
fi

if [ "$SYSTEM" = "Darwin" ]; then
  CURRENT="$(date '+%Y-%m-%d %H:%M:%S') darwin rebuild"
else
  CURRENT="$($REBUILD list-generations | grep -m 1 current)"
fi

git switch main
git merge --squash "$GITBRANCH"
git commit --message "$CURRENT"
git branch -f "$GITBRANCH"
