#!/bin/sh

set -e -o pipefail

# Get an updated config.sub and config.guess
if [[ "$target_platform" != "win-64" ]]; then
  cp $BUILD_PREFIX/share/gnuconfig/config.* .
fi

if [[ "${target_platform}" == "osx-arm64" ]]; then
    EXTRA_CONFIGURE_ARGS="--disable-simd --build=x86_64-pc-cygwin"
fi
./configure --prefix=$PREFIX --without-included-zlib --without-included-popt ${EXTRA_CONFIGURE_ARGS:-}
[[ "$target_platform" == "win-64" ]] && patch_libtool
make -j${CPU_COUNT}
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
    make check
fi
make install
