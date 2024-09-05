#!/bin/bash

set -e

[[ $1 =~ ^[0-9.]+$ ]] || { echo "First arg should be version" >&2; exit 1; }
[[ $2 =~ ^(stable|exp)$ ]] || { echo "Invalid channel (stable|exp)." >&2; exit 1; }

version=$1
channel=$2
docker_image="rfvgyhn/factorio"
build_args=""
commit_message="upgrade $channel to $version"
tags=("latest")

exp() {
    sed -i "s/^exp.*$/exp: $version/" version.txt
    sed -i "s|^\[7\].*|[7]: https://img.shields.io/badge/v-$version-blue|" README.md
    sed -i "s|^\[10\].*|[10]: https://img.shields.io/docker/image-size/$docker_image/$version-experimental|" README.md
    sed -i "s|^\[11\].*|[11]: https://img.shields.io/badge/v-$version-blue|" README.md
    tags+=("$version-experimental")
}

stable() {
    sed -i "s/^stable.*$/stable: $version/" version.txt
    sed -i "s|^\[7\].*|[7]: https://img.shields.io/badge/v-$version-blue|" README.md
    sed -i "s|^\[9\].*|[9]: https://img.shields.io/badge/v-$version-blue|" README.md
    tags+=("stable" "$version")
}

build() {
    docker build \
		--build-arg VERSION="$version" \
		--build-arg CREATED=$(date -u -Iseconds) \
		--build-arg SOURCE=$(git config --get remote.origin.url) \
		--build-arg REVISION=$(git rev-parse --short HEAD) \
		${build_args} \
		-t "$docker_image:latest" .
}

tag() {
    docker tag "$docker_image" "$docker_image:$1"
}

push() {
    docker push "$docker_image:$1"
}

echo "Version: $version"
echo "Channel: $channel"

if [[ $channel = "exp" ]]; then
    exp
elif [[ $channel = "stable" ]]; then
    stable
fi

git add version.txt README.md
git commit -m "$commit_message" || true

build

for t in ${tags[@]}; do
    tag "$t"
    push "$t"
done

docker pushrm "$docker_image" # https://github.com/christian-korneck/docker-pushrm
