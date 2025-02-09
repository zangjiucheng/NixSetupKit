#!/bin/sh
# set -eu

NIXOSCONFIG="${1:-nixos}"
GITBRANCH="${2:-build}"

git switch --quiet --merge "$GITBRANCH"

if ! git diff --quiet --no-ext-diff; then
  git commit --quiet --all --message '_'
fi

if git diff --quiet --no-ext-diff main; then
  exit 0
fi

rm -f result

if ! sudo nixos-rebuild switch --show-trace \
  --flake ".#${NIXOSCONFIG}" \
  >/dev/null; then
  exit 1
fi

CURRENT="$(nixos-rebuild list-generations | grep -m 1 current)"
git switch main
git merge --squash "$GITBRANCH"
git commit --message "$CURRENT"
git branch -f "$GITBRANCH"
