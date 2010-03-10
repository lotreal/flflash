#!/bin/bash
(
echo mxmlc -debug=true -static-link-runtime-shared-libraries=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=/home/lot/workspace/flflash/lib/ -sp+=/home/lot/workspace/flflash/etc/local/as3/ /home/lot/workspace/flflash/src/Main.as -o /home/lot/workspace/flflash/build/local/local/flf.swf

while : 
do read n 
    case $n in 
        r)  # 重新编译
            echo compile 1
            ;; 
        q)  # 退出
            break
            ;; 
    esac 
done
) | ~/share/flex4sdk/bin/fcsh