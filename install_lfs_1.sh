#! /bin/bash

set -e

#binutils pass 1

tar xf binutils-2.25.1.tar.bz2

mkdir -v binutils-build
cd binutils-build

../binutils-2.25.1/configure \
--prefix=/tools \
--with-sysroot=$LFS \
--with-lib-path=/tools/lib \
--target=$LFS_TGT \
--disable-nls \
--disable-werror

make

case $(uname -m) in
x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
esac

make install

cd ..
rm -rf binutils-2.25.1 binutils-build


#gcc pass 1

tar xf gcc-5.2.0.tar.bz2

cd gcc-5.2.0

tar -xf ../mpfr-3.1.3.tar.xz
mv -v mpfr-3.1.3 mpfr
tar -xf ../gmp-6.0.0a.tar.xz
mv -v gmp-6.0.0 gmp
tar -xf ../mpc-1.0.3.tar.gz
mv -v mpc-1.0.3 mpc

mkdir -v ../gcc-build
cd ../gcc-build

for file in \
$(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
do
cp -uv $file{,.orig}
sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
-e 's@/usr@/tools@g' $file.orig > $file
echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
touch $file.orig
done

../gcc-5.2.0/configure                             \
    --target=$LFS_TGT                              \
    --prefix=/tools                                \
    --with-glibc-version=2.11                      \
    --with-sysroot=$LFS                            \
    --with-newlib                                  \
    --without-headers                              \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --disable-nls                                  \
    --disable-shared                               \
    --disable-multilib                             \
    --disable-decimal-float                        \
    --disable-threads                              \
    --disable-libatomic                            \
    --disable-libgomp                              \
    --disable-libquadmath                          \
    --disable-libssp                               \
    --disable-libvtv                               \
    --disable-libstdcxx                            \
    --enable-languages=c,c++

make

make install

cd ..
rm -rf gcc-5.2.0 gcc-build

#linux headers

tar xf linux-4.2.tar.xz
cd linux-4.2

make mrproper

make INSTALL_HDR_PATH=dest headers_install
cp -rv dest/include/* /tools/include

cd ..
rm -rf linux-4.2

#glibc

tar xf glibc-2.22.tar.xz
cd glibc-2.22

patch -Np1 -i ../glibc-2.22-upstream_i386_fix-1.patch

mkdir -v ../glibc-build
cd ../glibc-build

../glibc-2.22/configure                             \
      --prefix=/tools                               \
      --host=$LFS_TGT                               \
      --build=$(../glibc-2.22/scripts/config.guess) \
      --disable-profile                             \
      --enable-kernel=2.6.32                        \
      --enable-obsolete-rpc                         \
      --with-headers=/tools/include                 \
      libc_cv_forced_unwind=yes                     \
      libc_cv_ctors_header=yes                      \
      libc_cv_c_cleanup=yes

make

make install

cd ..
rm -rf glibc-build glibc-2.22
