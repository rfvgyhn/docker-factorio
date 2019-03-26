#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 VERSION" >&2
    exit 1
fi

VER=$1

sed -i -e "3s/\(v\)[[:digit:]]\+\.[[:digit:]]\+\.[[:digit:]]\+/\1$VER/" README.md
sed -i -e "6s/\(.*VERSION=\)[[:digit:]]\+\.[[:digit:]]\+\.[[:digit:]]\+/\1$VER/" Dockerfile

git add .
git commit -m "upgrade to $VER"
git tag "$VER-experimental"