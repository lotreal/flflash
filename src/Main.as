// ~/share/flex4sdk/bin/mxmlc -debug=true -static-link-runtime-shared-libraries=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=/home/lot/workspace/flflash/lib/ -sp+=/home/lot/workspace/flflash/etc/debug/as3/ /home/lot/workspace/flflash/src/Main.as -o /home/lot/workspace/flflash/build/flf.swf
// ~/share/flex4sdk/bin/mxmlc -debug=false -static-link-runtime-shared-libraries=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=/home/lot/workspace/flflash/lib/ -sp+=/home/lot/workspace/flflash/etc/deploy/as3/ /home/lot/workspace/flflash/src/Main.as -o /home/lot/workspace/flflash/release/flf.swf
package {
    import flash.display.Sprite;
    import flash.events.Event;
    
    import flf.flatland.game.Director;
    
    import im.luo.staff.Context;

    [SWF(width="750", height="485", backgroundColor="#000000", frameRate="30")]
    public class Main extends Sprite {
        public function Main() {
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        public function init(event:Event = null):void {
            Context.Init(this);
            Director.instance.play();
        }
    }
}