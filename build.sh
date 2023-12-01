#!/bin/bash

set -e

tar -xf binutils-2.19.1.tar.bz2
tar -xf gcc-4.3.2.tar.bz2
tar -xf insight-6.8.tar.bz2
tar -xf newlib-1.16.0.tar.gz

mkdir build
mkdir build/binutils-2.19
mkdir build/gcc-4.3.2
mkdir build/newlib-1.16.0
mkdir build/insight-6.8
mkdir target

ROOTDIR=`pwd`
PATH="$ROOTDIR/target/bin:$PATH"

sed -i -e 's/MULTILIB_OPTIONS     = marm\/mthumb/MULTILIB_OPTIONS     = marm\/mthumb mno-thumb-interwork\/mthumb-interwork/' $ROOTDIR/gcc-4.3.2/gcc/config/arm/t-arm-elf 
sed -i -e 's/MULTILIB_DIRNAMES    = arm thumb/MULTILIB_DIRNAMES    = arm thumb normal interwork/' $ROOTDIR/gcc-4.3.2/gcc/config/arm/t-arm-elf

cd $ROOTDIR/build/binutils-2.19
../../binutils-2.19.1/configure --target=arm-elf --prefix="$ROOTDIR/target/" --enable-interwork --enable-multilib --with-float=soft --disable-werror
make all install

cd $ROOTDIR/build/gcc-4.3.2
../../gcc-4.3.2/configure --target=arm-elf --prefix="$ROOTDIR/target/" --enable-interwork --enable-multilib --with-float=soft --disable-werror --enable-languages="c,c++" --with-newlib --with-headers="$ROOTDIR/newlib-1.16.0/newlib/libc/include" CFLAGS="-fgnu89-inline"
make all-gcc install-gcc

cd $ROOTDIR/build/newlib-1.16.0
../../newlib-1.16.0/configure --target=arm-elf --prefix="$ROOTDIR/target/" --enable-interwork --enable-multilib --with-float=soft --disable-werror
make all install

cd $ROOTDIR/build/gcc-4.3.2
make all install

cd $ROOTDIR/build/insight-6.8
../../insight-6.8/configure --target=arm-elf --prefix="$ROOTDIR/target/" --enable-interwork --enable-multilib --with-float=soft --disable-werror
make all install


