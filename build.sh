#!/bin/sh
mkdir -p /src/build
mkdir -p /src/binaries
cd /src/build || exit 255
cmake .. -DCMAKE_INSTALL_PREFIX=/tc \
        -DOPENSSL_SSL_LIBRARIES=/usr/lib/x86_64-linux-gnu/libssl.so \
        -DOPENSSL_CRYPTO_LIBRARIES=/usr/lib/x86_64-linux-gnu/libcrypto.so \
        -DREADLINE_LIBRARY=/lib/x86_64-linux-gnu/libreadline.so.5 \
        -DZLIB_LIBRARY=/usr/lib/x86_64-linux-gnu/libz.so \
        -DBOOST_LIBRARYDIR=/usr/lib/x86_64-linux-gnu \
        -DBOOST_ROOT=/usr/lib/x86_64-linux-gnu \
        -DWITH_WARNINGS=0 \
        -DWITH_COREDEBUG=0 \
        -DUSE_COREPCH=1 \
        -DUSE_SCRIPTPCH=1 \
        -DTOOLS=0 \
        -DSCRIPTS=static \
        -DNOJEM=0 \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DCMAKE_C_COMPILER="gcc" \
        -DCMAKE_CXX_FLAGS="-m64 -std=c++14 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -pipe -fno-strict-aliasing -fpermissive" \
        -DCMAKE_C_FLAGS="-m64 -std=c++14 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -pipe -fno-strict-aliasing -fpermissive" \
  || exit 255
make -j4 || exit 255
make install || exit 255
cp -rf /tc/* /src/binaries/
cp -rf /src/sql /src/binaries/sql
