#!/bin/bash -i

set -e
source ./library_scripts.sh

# nanolayer is a cli utility which keeps container layers as small as possible
# source code: https://github.com/devcontainers-contrib/nanolayer
# `ensure_nanolayer` is a bash function that will find any existing nanolayer installations, 
# and if missing - will download a temporary copy that automatically get deleted at the end 
# of the script
ensure_nanolayer nanolayer_location "v0.5.6"

$nanolayer_location \
    install \
    devcontainer-feature \
    "ghcr.io/devcontainers-contrib/features/apt-get-packages:1.0.6" \
    --option packages='curl,ca-certificates,unzip'

IFS=','
echo "uname -m = $(uname -m)"

# example
# PRODUCTS=vault=1.7.0,terraform=4.2.8
for product in $PRODUCTS; do
    IFS='='
    read -r PRODUCT VERSION <<< "$product"

    if [[ $(uname -m) == "x86_64" || $(uname -m) == "amd" || $(uname -m) == "amd64" ]]; then
        curl -Lo binary.zip https://${MIRROR}/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_linux_amd64.zip
    elif [[ $(uname -m) == "arm64" || $(uname -m) == "aarch64" ]]; then
        curl -Lo binary.zip https://${MIRROR}/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_linux_arm64.zip
    elif [[ $(uname -m) == "arm" ]]; then
        curl -Lo binary.zip https://${MIRROR}/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_linux_arm.zip
    else
        echo "Unsupported architecture"
        exit 1
    fi

    unzip binary.zip ${PRODUCT}
    install ${PRODUCT} /usr/local/bin
    rm -rf binary.zip ${PRODUCT}
done
