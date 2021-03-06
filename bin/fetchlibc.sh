#!/bin/sh
set -e

# use your favourite mirror
# sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

LIB_DIR=/libc-i386

# install debian i386 libraries
dpkg --add-architecture i386
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get -y install libssl1.0.0:i386

# configuration for i386 loader
mkdir -p $LIB_DIR/etc
echo "/lib/i386-linux-gnu" > $LIB_DIR/etc/ld.so.conf

# copy i386 libraries
mkdir -p $LIB_DIR/lib/i386-linux-gnu
cp -a /lib/ld-linux.so.2 $LIB_DIR/lib/
cp -a /lib/i386-linux-gnu/ld* $LIB_DIR/lib/i386-linux-gnu/
cp -a /lib/i386-linux-gnu/libc[-.]* $LIB_DIR/lib/i386-linux-gnu/
cp -a /lib/i386-linux-gnu/libdl[-.]* $LIB_DIR/lib/i386-linux-gnu/
cp -a /lib/i386-linux-gnu/libgcc_s[-.]* $LIB_DIR/lib/i386-linux-gnu/
cp -a /lib/i386-linux-gnu/libm[-.]* $LIB_DIR/lib/i386-linux-gnu/
cp -a /lib/i386-linux-gnu/libpthread[-.]* $LIB_DIR/lib/i386-linux-gnu/
cp -a /usr/lib/i386-linux-gnu/libcrypto[-.]* $LIB_DIR/lib/i386-linux-gnu/
ln -s libcrypto.so.1.0.0 $LIB_DIR/lib/i386-linux-gnu/libcrypto.so.4

# store in tar archive
echo
echo "Storing i386 libs into libc-i386.tar.gz..."
echo
tar -cvvzf /base/libc-i386.tar.gz -C $LIB_DIR `ls $LIB_DIR`
chown --reference=/base /base/libc-i386.tar.gz