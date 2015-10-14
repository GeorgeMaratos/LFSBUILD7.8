
#! /bin/bash
set -e


#zlib-1.2.8.tar.xz
tar xf zlib-1.2.8.tar.xz
cd zlib-1.2.8

./configure --prefix=/usr
make
make install
mv -v /usr/lib/libz.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so

cd ..
rm -rf zlib-1.2.8

#file-5.24.tar.gz

tar xf file-5.24.tar.gz
cd file-5.24

./configure --prefix=/usr
make
make install

cd ..
rm -rf file-5.24

#binutils-2.25.1.tar.bz2

tar xf binutils-2.25.1.tar.bz2
cd binutils-2.25.1
expect -c "spawn ls"
