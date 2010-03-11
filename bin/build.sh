#!/bin/bash

FLAG="local"
DEBUG_FLAG=true

if [ "$1" = "r"  ] ; then
    FLAG="release"
    DEBUG_FLAG=false
fi

if [ "$1" = "b"  ] ; then
    FLAG="beta"
    DEBUG_FLAG=false
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

LOADER_CC="mxmlc -debug=$DEBUG_FLAG -static-link-runtime-shared-libraries=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=$FLF/lib/ -sp+=$FLF/etc/$FLAG/as3/ $FLF/src/IMLoader.as -o $OUT/loader.swf"

FLF_CC="mxmlc -debug=$DEBUG_FLAG -static-link-runtime-shared-libraries=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=$FLF/lib/ -sp+=$FLF/etc/$FLAG/as3/ $FLF/src/Main.as -o $OUT/flf.swf"

if [ $FLAG != "local" ] ; then
    eval $LOADER_CC
    eval $FLF_CC
    cd $FLF; find resource/ -type f -not -iname "*.fla"  -exec cp --parents {} $OUT -r \;
    ncftpput -R -m -f ~/etc/ftp.flf.rc /links/flatlandgame.com/fb/flf $BUILD/*
else
    cd $FLF; find resource/ -type f -not -iname "*.fla"  -exec cp --parents {} $OUT -r \;
    (
    echo $LOADER_CC
    echo $FLF_CC

    while : 
    do read n 
        case $n in 
            r)  # 重新编译
                echo compile 1
                echo compile 2
                ;; 
            q)  # 退出
                exit
                ;; 
        esac 
    done
    ) | fcsh
fi