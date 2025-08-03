#!/bin/bash
ORG=kubesphere
mkdir -p tags

while read -r IMAGE; do
  echo "Fetching tags for $IMAGE..."
  PAGE=1
  > tags/${IMAGE}.txt
  while true; do
    RESP=$(curl -s "https://hub.docker.com/v2/repositories/${ORG}/${IMAGE}/tags?page_size=100&page=$PAGE")
    echo "$RESP" | jq -r '.results[].name' >> tags/${IMAGE}.txt
    NEXT=$(echo "$RESP" | jq -r '.next')
    [ "$NEXT" == "null" ] && break
    ((PAGE++))
  done
done < kubesphere-images.txt
