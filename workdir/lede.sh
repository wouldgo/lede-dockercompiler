#!/usr/bin/env bash

#opkg install ca-certificates ca-bundle libustream-mbedtls

WORKDIR=/workdir
VERSION='17.01.4'

cd ${WORKDIR} && \
wget http://downloads.lede-project.org/releases/${VERSION}/targets/ramips/mt7620/lede-sdk-${VERSION}-ramips-mt7620_gcc-5.4.0_musl-1.1.16.Linux-x86_64.tar.xz \
  -O lede-sdk.tar.xz && \
mkdir lede && tar xvf lede-sdk.tar.xz -C lede --strip-components 1 && \
rm -Rfv lede-sdk.tar.xz

export STAGING_DIR=${WORKDIR}/lede-sdk/staging_dir && \
export PATH=${WORKDIR}/lede-sdk/staging_dir/toolchain-mipsel_24kc_gcc-5.4.0_musl-1.1.16/bin:${PATH} && \

cd ${WORKDIR}/lede && \
echo "src-link pmacct ${WORKDIR}/pmacct" >> feeds.conf.default && \
./scripts/feeds update -a && \
./scripts/feeds install pmacct
