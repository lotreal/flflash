#!/bin/bash
rm /home/lot/workspace/flflash/release/ -rf
mkdir /home/lot/workspace/flflash/release/
~/share/flex4sdk/bin/mxmlc -debug=false -static-link-runtime-shared-libraries=true -sp+=/home/lot/workspace/flflash/lib/ -sp+=/home/lot/workspace/flflash/etc/deploy/as3/ /home/lot/workspace/flflash/src/IMLoader.as -o /home/lot/workspace/flflash/release/loader.swf
~/share/flex4sdk/bin/mxmlc -debug=false -static-link-runtime-shared-libraries=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=/home/lot/workspace/flflash/lib/ -sp+=/home/lot/workspace/flflash/etc/deploy/as3/ /home/lot/workspace/flflash/src/Main.as -o /home/lot/workspace/flflash/release/flf.swf
cp /home/lot/workspace/flflash/build/resource/ /home/lot/workspace/flflash/release/ -r