#!/bin/bash
ORG=kubesphere
PAGE_SIZE=100

mkdir -p ./kubesphere-tags
PAGE=1
while true; do
  echo "Fetching page $PAGE..."
  RESP=$(curl -s "https://hub.docker.com/v2/repositories/${ORG}/?page_size=${PAGE_SIZE}&page=$PAGE")
  echo "$RESP" | jq -r '.results[].name' > "kubesphere-tags/page-${PAGE}.txt"
  NEXT=$(echo "$RESP" | jq -r '.next')
  [ "$NEXT" == "null" ] && break
  ((PAGE++))
done

cat kubesphere-tags/page-*.txt | sort -u > kubesphere-images.txt
