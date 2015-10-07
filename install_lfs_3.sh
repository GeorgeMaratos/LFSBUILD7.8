#! /bin/bash
set -e

#tcl-core8.6.4-src.tar.gz

tar xf tcl-core8.6.4-src.tar.gz
cd tcl-core8.6.4

cd unix
./configure --prefix=/tools

make
TZ=UTC make test

make install

make install-private-headers

ln -sv tclsh8.6 /tools/bin/tclsh

cd ../..
rm -rf tcl-core8.8.4

#expect5.45.tar.gz

tar xf expect5.45.tar.gz
cd expect5.45

cp -v configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure

./configure --prefix=/tools       \
            --with-tcl=/tools/lib \
            --with-tclinclude=/tools/include

make

make SCRIPTS="" install

cd ..
rm -rf expect5.45

#dejagnu-1.5.3.tar.gz

tar xf dejagnu-1.5.3.tar.gz
cd dejagnu-1.5.3

./configure --prefix=/tools

make install

cd ..
rm -rf dejagnu-1.5.3

#check-0.10.0.tar.gz

tar xf check-0.10.0.tar.gz
cd check-0.10.0

PKG_CONFIG= ./configure --prefix=/tools

make
make install

cd ..
rm -rf check-0.10.0

#ncurses-6.0.tar.gz

tar xf ncurses-6.0.tar.gz
cd ncurses-6.0

sed -i s/mawk// configure

./configure --prefix=/tools \
            --with-shared   \
            --without-debug \
            --without-ada   \
            --enable-widec  \
            --enable-overwrite

make
make install

cd ..
rm -rf ncurses-6.0.tar.gz

#bash-4.3.30.tar.gz

tar xf bash-4.3.30.tar.gz
cd bash-4.3.30

./configure --prefix=/tools --without-bash-malloc

make
make install

ln -sv bash /tools/bin/sh

cd ..
rm -rf bash-4.3.30

#bzip2-1.0.6.tar.gz

tar xf bzip2-1.0.6.tar.gz
cd bzip2-1.0.6

make
make PREFIX=/tools install

cd ..
rm -rf bzip2-1.0.6

#coreutils-8.24.tar.xz

tar xf coreutils-8.24.tar.xz
cd coreutils-8.24

./configure --prefix=/tools --enable-install-program=hostname

make
make install

cd ..
rm -rf coreutils-8.24

#diffutils-3.3.tar.xz

tar xf diffutils-3.3.tar.xz
cd diffutils-3.3

./configure --prefix=/tools

make
make install

cd ..
rm -rf diffutils-3.3

#file-5.24.tar.gz

tar xf file-5.24.tar.gz
cd file-5.24

./configure --prefix=/tools

make
make install

cd ..
rm -rf file-5.24

#findutils-4.4.2.tar.gz

tar xf findutils-4.4.2.tar.gz
cd findutils-4.4.2

./configure --prefix=/tools

make
make install

cd ..
rm -rf findutils-4.4.2

#gawk-4.1.3.tar.xz

tar xf gawk-4.1.3.tar.xz
cd gawk-4.1.3

./configure --prefix=/tools

make
make install

cd ..
rm -rf gawk-4.1.3

#gettext-0.19.5.1.tar.xz

tar xf gettext-0.19.5.1.tar.xz
cd gettext-0.19.5.1

cd gettext-tools
EMACS="no" ./configure --prefix=/tools --disable-shared

make -C gnulib-lib
make -C intl pluralx.c
make -C src msgfmt
make -C src msgmerge
make -C src xgettext

cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin

cd ../..
rm -rf gettext-0.19.5.1

#grep-2.21.tar.xz

tar xf grep-2.21.tar.xz
cd grep-2.21

./configure --prefix=/tools

make
make install

cd ..
rm -rf grep-2.21

#gzip-1.6.tar.xz

tar xf gzip-1.6.tar.xz
cd gzip-1.6

./configure --prefix=/tools

make
make install

cd ..
rm -rf gzip-1.6

#m4-1.4.17.tar.xz

tar xf m4-1.4.17.tar.xz
cd m4-1.4.17

./configure --prefix=/tools

make
make install

cd ..
rm -rf m4-1.4.17

#make-4.1.tar.bz2

tar xf make-4.1.tar.bz2
cd make-4.1

./configure --prefix=/tools --without-guile

make
make install

cd ..
rm -rf make-4.1

#patch-2.7.5.tar.xz

tar xf patch-2.7.5.tar.xz
cd patch-2.7.5

./configure --prefix=/tools

make
make install

cd ..
rm -rf patch-2.7.5

#perl-5.22.0.tar.bz2

tar xf perl-5.22.0.tar.bz2
cd perl-5.22.0

sh Configure -des -Dprefix=/tools -Dlibs=-lm

make

cp -v perl cpan/podlators/pod2man /tools/bin
mkdir -pv /tools/lib/perl5/5.22.0
cp -Rv lib/* /tools/lib/perl5/5.22.0

cd ..
rm -rf perl-5.22.0

#sed-4.2.2.tar.bz2

tar xf sed-4.2.2.tar.bz2
cd sed-4.2.2

./configure --prefix=/tools

make
make install

cd ..
rm -rf sed-4.2.2


#tar-1.28.tar.xz

tar xf tar-1.28.tar.xz
cd tar-1.28

./configure --prefix=/tools

make
make install

cd ..
rm -rf tar-1.28


#texinfo-6.0.tar.xz

tar xf texinfo-6.0.tar.xz
cd texinfo-6.0

./configure --prefix=/tools

make
make install

cd ..
rm -rf texinfo-6.0


#util-linux-2.27.tar.xz

tar xf util-linux-2.27.tar.xz
cd util-linux-2.27

./configure --prefix=/tools                \
            --without-python               \
            --disable-makeinstall-chown    \
            --without-systemdsystemunitdir \
            PKG_CONFIG=""

make
make install

cd ..
rm -rf util-linux-2.27


#xz-5.2.1.tar.xz

tar xf xz-5.2.1.tar.xz
cd xz-5.2.1

./configure --prefix=/tools

make
make install

cd ..
rm -rf xz-5.2.1
