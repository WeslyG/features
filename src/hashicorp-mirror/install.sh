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

uname_output=$(uname -m)
if [[ $(uname -m) == "x86_64" ]]; then
    curl -Lo product.zip https://${MIRROR}/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_linux_amd64.zip
elif [[ $(uname -m) == "arm64" || $(uname -m) == "aarch64" ]]; then
    curl -Lo product.zip https://${MIRROR}/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_linux_arm64.zip
elif [[ $(uname -m) == "amd" ]]; then
    curl -Lo product.zip https://${MIRROR}/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_linux_arm.zip
else
    echo "Unsupported architecture"
    exit 1
fi

unzip product.zip ${PRODUCT}
install ${PRODUCT} /usr/local/bin
rm -rf product.zip ${PRODUCT}