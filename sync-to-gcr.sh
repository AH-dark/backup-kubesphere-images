#!/bin/bash
SRC_REG="docker://docker.io"
DST_REG="docker://asia-east2-docker.pkg.dev/ahdark-services/kubesphere"
ORG="kubesphere"

while read -r IMAGE; do
  echo "🔍 Processing image: $IMAGE"
  while read -r TAG; do
    SRC="${SRC_REG}/${ORG}/${IMAGE}:${TAG}"
    DST="${DST_REG}/${IMAGE}:${TAG}"
    echo "📦 Copying $SRC → $DST"
    skopeo copy --insecure-policy --all "$SRC" "$DST" || echo "❌ Failed: $IMAGE:$TAG"
  done < tags/${IMAGE}.txt
done < kubesphere-images.txt
