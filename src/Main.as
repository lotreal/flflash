// ~/share/flex4sdk/bin/mxmlc -debug=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=/home/lot/workspace/flflash/lib/ -static-link-runtime-shared-libraries=true /home/lot/workspace/flflash/src/Main.as -o /home/lot/workspace/flflash/bin/flf.swf
package {
    import flash.display.*;
    import flash.display.StageScaleMode;
    import flash.events.*;
    import com.hexagonstar.util.debug.Debug;

    [SWF(width="1000", height="600", backgroundColor="#000000", frameRate="30")]
    public class Main extends Sprite {
        public static var context:Context;
        public function Main() {
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        public function init(event:MouseEvent = null):void {
            Debug.monitor(stage, 1000);
            Context.Init(this);
        }
    }
}