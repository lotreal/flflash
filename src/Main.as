// ~/share/flex4sdk/bin/mxmlc -debug=true -library-path+=/home/lot/sf/ActionScript/alcon/as3/alcon.swc -sp+=/home/lot/workspace/flflash/lib/ -static-link-runtime-shared-libraries=true /home/lot/workspace/flflash/src/Main.as -o /home/lot/workspace/flflash/bin/flf.swf
package {
    import com.hexagonstar.util.debug.Debug;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flf.flatland.game.Context;

    [SWF(width="750", height="550", backgroundColor="#000000", frameRate="30")]
    public class Main extends Sprite {
        public static var context:Context;
        public function Main() {
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        public function init(event:Event = null):void {
            Debug.monitor(stage, 1000);
            Context.Init(this);
        }
    }
}