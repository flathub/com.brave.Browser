#!/bin/bash

flatpak=(
	$(curl -so- https://brave-browser-apt-release.s3.brave.com/dists/stable/main/binary-amd64/Packages.gz |
		gzip -d - |
		awk '/Package: brave-browser/' RS= -|
		grep -Em3 '^(Filename:|SHA256:|Size:)'|
		awk '{print $NF}')
)

echo "url: https://brave-browser-apt-release.s3.brave.com/${flatpak[0]}"
echo "sha256: ${flatpak[2]}"
echo "size: ${flatpak[1]}"

