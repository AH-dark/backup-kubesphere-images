#!/bin/bash
mkdir -p filtered-tags

for FILE in tags/*.txt; do
  IMAGE=$(basename "$FILE" .txt)
  echo "🎯 Filtering tags for $IMAGE"
  grep -E '^v.*|^latest$' "$FILE" | sort -u > filtered-tags/${IMAGE}.txt
done
