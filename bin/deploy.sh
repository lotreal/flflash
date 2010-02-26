#!/bin/bash

if [ "$1" = ""  ] ; then
     FLAG="release"
else
     FLAG="beta"
fi

FLF="/home/lot/workspace/flflash"
OUT="$FLF/build/flf/$FLAG"
echo "Compile to Dir: $OUT"

rm $OUT -r
mkdir $OUT -p

cp $FLF/html-template/* $OUT -r
