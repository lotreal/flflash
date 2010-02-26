#!/bin/bash

FLAG="local"

FLF="/home/lot/workspace/flflash"
BUILD="$FLF/build"
OUT="$BUILD/$FLAG"

echo "Compile to Dir: $OUT"

rm $BUILD -r
mkdir $BUILD -p

cp $FLF/web/$FLAG/* $BUILD -r

mkdir $OUT -p

~/share/flex4sdk/bin/mxmlc -debug=true -static-link-runtime-shared-libraries=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=$FLF/lib/ -sp+=$FLF/etc/debug/as3/ $FLF/src/Main.as -o $OUT/flf.swf

~/share/flex4sdk/bin/mxmlc -debug=true -static-link-runtime-shared-libraries=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=$FLF/lib/ -sp+=$FLF/etc/debug/as3/ $FLF/src/IMLoader.as -o $OUT/loader.swf