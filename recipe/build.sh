#!/bin/sh

set -e -o pipefail

./configure --prefix=$PREFIX

make -j${CPU_COUNT} install
