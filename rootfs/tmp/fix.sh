#!/bin/sh
set -x
rm -f /usr/local/lib/libssh2* /usr/local/lib/libcurl* 2>/dev/null || true
case $(uname -m) in
x86_64)
	python -c "import urllib.request; urllib.request.urlretrieve('https://archive.archlinux.org/packages/c/curl/curl-8.10.1-1-x86_64.pkg.tar.zst', '/tmp/curl.pkg.tar.zst')" || echo failed to get curl-x86_64
	python -c "import urllib.request; urllib.request.urlretrieve('https://archive.archlinux.org/packages/l/libssh2/libssh2-1.11.0-1-x86_64.pkg.tar.zst', '/tmp/libssh2.pkg.tar.zst')" echo failed to get libssh2-x86_64
	;;
aarch64)
	python -c "import urllib.request; urllib.request.urlretrieve('http://mirror.archlinuxarm.org/aarch64/core/curl-8.16.0-1-aarch64.pkg.tar.xz', '/tmp/curl.pkg.tar.zst'))" || echo failed to get curl-aarch64
	python -c "import urllib.request; urllib.request.urlretrieve('http://mirror.archlinuxarm.org/aarch64/core/libssh2-1.11.1-1-aarch64.pkg.tar.xz', '/tmp/libssh2.pkg.tar.zst')" || echo failed to get libssh2-aarch64
	;;
esac
# Extract the packages to fix the libraries
tar --overwrite -xf /tmp/curl.pkg.tar.zst -C / --exclude .PKGINFO --exclude .INSTALL
tar --overwrite -xf /tmp/libssh2.pkg.tar.zst -C / --exclude .PKGINFO --exclude .INSTALL
rm -f /tmp/*.pkg.tar.zst
