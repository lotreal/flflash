#!/bin/bash
FLF="/home/lot/workspace/flflash"
rm "$FLF/build" -r
cp "$FLF/html-template/" "$FLF/build" -r

~/share/flex4sdk/bin/mxmlc -debug=true -static-link-runtime-shared-libraries=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=/home/lot/workspace/flflash/lib/ -sp+=/home/lot/workspace/flflash/etc/debug/as3/ /home/lot/workspace/flflash/src/Main.as -o /home/lot/workspace/flflash/build/flf.swf

~/share/flex4sdk/bin/mxmlc -debug=true -static-link-runtime-shared-libraries=true -sp+=/home/lot/workspace/flflash/lib/ -sp+=/home/lot/workspace/flflash/etc/debug/as3/ /home/lot/workspace/flflash/src/IMLoader.as -o /home/lot/workspace/flflash/build/loader.swf

ln -s "$FLF/resource/" "$FLF/build/"