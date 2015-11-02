#! /bin/sh -e

if test -z "$SRCDIR" || test -z "$PINTOSDIR" || test -z "$DSTDIR"; then
    echo "usage: env SRCDIR=<srcdir> PINTOSDIR=<srcdir> DSTDIR=<dstdir> sh $0"
    echo "  where <srcdir> contains bochs-2.6.2.tar.gz"
    echo "    and <pintosdir> is the root of the pintos source tree"
    echo "    and <dstdir> is the installation prefix (e.g. /usr/local)"
    exit 1
fi

cd /tmp
mkdir $$
cd $$
mkdir bochs-2.6.8
tar xzf $SRCDIR/bochs-2.6.8.tar.gz
cd bochs-2.6.8

#CFGOPTS="--with-x --with-x11 --with-term --with-sdl --with-nogui --prefix=$DSTDIR"

CFGOPTS="--with-x --with-x11 --with-term --with-sdl --with-nogui --enable-magic-breakpoint --prefix=$DSTDIR"
mkdir plain &&
        cd plain &&
        ../configure $CFGOPTS --enable-gdb-stub &&
        make &&
        make install &&
        cd ..
mkdir with-dbg &&
        cd with-dbg &&
        ../configure --enable-debugger $CFGOPTS &&
        make &&
        cp bochs $DSTDIR/bin/bochs-dbg &&
        cd ..

