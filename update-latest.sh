#!/usr/bin/env bash
set -e
cd "$( dirname "$0" )"
RESOURCE_PATH=youtube-dl/update/LATEST_VERSION
CURRENT="$( cat "$RESOURCE_PATH" )"
LATEST="$( curl -s "https://ytdl-org.github.io/$RESOURCE_PATH" )"
echo "Current: $CURRENT"
echo "Latest:  $LATEST"
if [[ "$CURRENT" != "$LATEST" ]]; then
    echo "Updating $RESOURCE_PATH"
    printf "%s" "$LATEST" >"$RESOURCE_PATH"
    git add "$RESOURCE_PATH"
    git commit -q -m "Update $RESOURCE_PATH"
    git push
else
    echo "Versions match. Nothing to do."
fi
