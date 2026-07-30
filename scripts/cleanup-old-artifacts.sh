#!/bin/bash

# Ensure the GitHub CLI is authenticated
if ! gh auth status > /dev/null 2>&1; then
  echo "Please authenticate with the GitHub CLI using 'gh auth login'."
  exit 1
fi

# Check if the owner is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <owner/repo>"
  echo "Example: $0 <owner/repo>"
  exit 1
fi

REPO=$1
DAYS_OLD=5
PAGE=1

echo "Cleaning up artifacts older than $DAYS_OLD days for repository: $REPO"

while true; do
  # Fetch artifacts for the repository (paginated)
  RESPONSE=$(gh api -H "Accept: application/vnd.github+json" \
    "/repos/$REPO/actions/artifacts?per_page=100&page=$PAGE")

  # Check if the response contains artifacts
  if [ "$(echo "$RESPONSE" | jq '.artifacts | length')" -eq 0 ]; then
    echo "No more artifacts found."
    break
  fi

  # Extract artifact details
  ARTIFACTS=$(echo "$RESPONSE" | jq -c '.artifacts[] | {id: .id, name: .name, created_at: .created_at}')

  for ARTIFACT in $ARTIFACTS; do
    ID=$(echo "$ARTIFACT" | jq -r '.id')
    NAME=$(echo "$ARTIFACT" | jq -r '.name')
    CREATED_AT=$(echo "$ARTIFACT" | jq -r '.created_at')

    # Validate extracted data
    if [ -z "$ID" ] || [ -z "$NAME" ] || [ -z "$CREATED_AT" ]; then
      echo "Skipping invalid artifact data: $ARTIFACT"
      continue
    fi

    # Calculate artifact age in days (macOS-compatible)
    # CREATED_AT_SECONDS=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "$CREATED_AT" +%s)

    # Calculate artifact age in days (Linux-compatible)
    CREATED_AT_SECONDS=$(date -d "$CREATED_AT" +%s)
    CURRENT_TIME=$(date +%s)
    AGE_DAYS=$(( (CURRENT_TIME - CREATED_AT_SECONDS) / 86400 ))

    if [ "$AGE_DAYS" -gt "$DAYS_OLD" ]; then
      echo "Deleting artifact: $NAME (ID: $ID, Age: $AGE_DAYS days)"
      gh api -X DELETE "/repos/$REPO/actions/artifacts/$ID" > /dev/null 2>&1
    else
      echo "Skipping artifact: $NAME (ID: $ID, Age: $AGE_DAYS days)"
    fi
  done

  # Check if there are more pages
  HAS_NEXT_PAGE=$(echo "$RESPONSE" | jq '.artifacts | length == 100')
  if [ "$HAS_NEXT_PAGE" != "true" ]; then
    break
  fi

  PAGE=$((PAGE + 1))
done

echo "Cleanup completed."
