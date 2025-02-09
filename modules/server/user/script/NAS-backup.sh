#!/bin/sh

# A script to perform incremental backups using rsync

set -e
set -u

SOURCE_DIR="/NAS"
BACKUP_DIR="/MyBook/NAS_Backups"
DATETIME="$(date '+%Y-%m-%d_%H-%M-%S')"
BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"
LATEST_FILE="${BACKUP_DIR}/latest.txt"

# Create the backup directory if it doesn't exist
mkdir -p "${BACKUP_DIR}"

# Determine the latest backup path from latest.txt (if it exists)
if [ -f "${LATEST_FILE}" ]; then
  LATEST_LINK="$(cat "${LATEST_FILE}")"
else
  LATEST_LINK=""
fi

# Perform the rsync backup
rsync -av --delete \
  --exclude-from="exclude-list.txt" \
  --compare-dest="${LATEST_LINK}" \
  "${SOURCE_DIR}/" \
  "${BACKUP_PATH}"

# Update the latest.txt file to point to the new backup
echo "${BACKUP_PATH}" >"${LATEST_FILE}"
