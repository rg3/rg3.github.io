#!/usr/bin/env bash
set -e
cd "$( dirname "$0" )"
RESOURCE_DIR=youtube-dl/update
FLAG_RESOURCE="$RESOURCE_DIR/LATEST_VERSION"
EXTRA_RESOURCES=("$RESOURCE_DIR/releases.atom" "$RESOURCE_DIR/versions.json")
BASE_URL=https://ytdl-org.github.io/
CURRENT="$( cat "$FLAG_RESOURCE" )"
LATEST="$( curl -s "$BASE_URL$FLAG_RESOURCE" )"
echo "Current: $CURRENT"
echo "Latest:  $LATEST"
if [[ "$CURRENT" != "$LATEST" ]]; then
    echo "Updating $FLAG_RESOURCE"
    printf "%s" "$LATEST" >"$FLAG_RESOURCE"
    for f in "${EXTRA_RESOURCES[@]}"; do
        curl -s "$BASE_URL$f" >"$f"
    done
    git add "$FLAG_RESOURCE" "${EXTRA_RESOURCES[@]}"
    git commit -q -m "Updating resources to $LATEST"
    git push
else
    echo "Versions match. Nothing to do."
fi
