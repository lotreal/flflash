#!/bin/bash

FLAG="local"

if [ "$1" = "r"  ] ; then
     FLAG="release"
fi

if [ "$1" = "b"  ] ; then
     FLAG="beta"
fi

FLF="/home/lot/workspace/flflash"
BUILD="$FLF/build/$FLAG"
OUT="$BUILD/$FLAG"

echo "Compile to Dir: $OUT"

if [ -d $BUILD ] ; then
    rm $BUILD -r
fi
mkdir $OUT -p

cp $FLF/web/* $OUT -r
cp $FLF/etc/$FLAG/web/* $BUILD -r

mkdir $OUT -p

~/share/flex4sdk/bin/mxmlc -debug=true -static-link-runtime-shared-libraries=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=$FLF/lib/ -sp+=$FLF/etc/$FLAG/as3/ $FLF/src/Main.as -o $OUT/flf.swf

~/share/flex4sdk/bin/mxmlc -debug=true -static-link-runtime-shared-libraries=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=$FLF/lib/ -sp+=$FLF/etc/$FLAG/as3/ $FLF/src/IMLoader.as -o $OUT/loader.swf

# cp $FLF/resource $OUT/ -r
cd $FLF; find resource/ -type f -not -iname "*.fla"  -exec cp --parents {} $OUT -r \;

if [ $FLAG != "local" ] ; then
    ncftpput -R -m -f ~/.flf.rc /links/flatlandgame.com/fb/flf $BUILD/*
fi