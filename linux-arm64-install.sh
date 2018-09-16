#! /usr/bin/env bash

set -e

## CI Dependency install script for arm 64 

# Remove the existing libraries, these conflict when instlaling
sudo apt-get purge -y libwebkit2gtk-4.0-dev libgtk-3-dev

# Add the arm64 architecture
cat > webview.list <<EOF
deb [arch=arm64] http://ports.ubuntu.com/ bionic main restricted
deb [arch=arm64] http://ports.ubuntu.com/ bionic-updates main restricted
deb [arch=arm64] http://ports.ubuntu.com/ bionic universe
deb [arch=arm64] http://ports.ubuntu.com/ bionic-updates universe
deb [arch=arm64] http://ports.ubuntu.com/ bionic multiverse
deb [arch=arm64] http://ports.ubuntu.com/ bionic-updates multiverse
deb [arch=arm64] http://ports.ubuntu.com/ bionic-backports main restricted universe multiverse
EOF
sudo mv webview.list /etc/apt/sources.list.d
sudo sed -ibk /etc/apt/sources.list -e 's/deb http/deb [arch=amd64] http/g'
sudo dpkg --add-architecture arm64

sudo apt-get update

# Add the dependencies for our chosen architecture
sudo apt-get install -y libwebkit2gtk-4.0-dev:arm64 libgtk-3-dev:arm64