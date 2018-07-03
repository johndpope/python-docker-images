#! /bin/bash
IMAGE_NAME=$1

set -e

docker build -t indico/$IMAGE_NAME -f Dockerfile_$IMAGE_NAME .
docker push indico/$IMAGE_NAME