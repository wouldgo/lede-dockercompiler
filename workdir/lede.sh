#!/usr/bin/env bash

#opkg install ca-certificates ca-bundle libustream-mbedtls

WORKDIR=/workdir
VERSION='17.01.4'
LEDEDIR=${WORKDIR}/lede
PACKAGE_NAME=pmacct_1.7.1-1_mipsel_24kc.ipk

cd ${WORKDIR} && \
rm -Rfv ${LEDEDIR} && \
wget http://downloads.lede-project.org/releases/${VERSION}/targets/ramips/mt7620/lede-sdk-${VERSION}-ramips-mt7620_gcc-5.4.0_musl-1.1.16.Linux-x86_64.tar.xz \
  -O lede-sdk.tar.xz && \
mkdir ${LEDEDIR} && tar xvf lede-sdk.tar.xz -C ${LEDEDIR} --strip-components 1 && \
rm -Rfv lede-sdk.tar.xz

export STAGING_DIR=${LEDEDIR}/staging_dir && \
export PATH=${LEDEDIR}/staging_dir/toolchain-mipsel_24kc_gcc-5.4.0_musl-1.1.16/bin:${PATH} && \

cd ${LEDEDIR} && \
echo "src-link pmacct ${WORKDIR}/pmacct" >> feeds.conf.default && \
./scripts/feeds update -a && \
./scripts/feeds install pmacct && \
cp -Rfv ${WORKDIR}/.config ${LEDEDIR} && \
make -j10 V=s && \

cp ${LEDEDIR}/bin/packages/mipsel_24kc/pmacct/${PACKAGE_NAME} ${WORKDIR} && \
sha256sum ${WORKDIR}/${PACKAGE_NAME}
