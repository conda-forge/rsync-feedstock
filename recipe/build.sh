#!/bin/sh

set -e -o pipefail

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .
./configure --prefix=$PREFIX

make -j${CPU_COUNT} install
