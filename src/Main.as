// ~/share/flex4sdk/bin/mxmlc -debug=true -sp+=/home/lot/sf/TowerBuilder/lib/ -sp+=/home/lot/sf/Box2D_2.0.1/ -sp+=/home/lot/sf/QuickBox2D_1.1/QuickBox2D_1.1/ -sp+=/home/lot/sf/tweener-read-only/as3/ -static-link-runtime-shared-libraries=true Main.as -o ../bin/flf.swf
package {
    import flash.display.*;
    import flash.display.StageScaleMode;
    import flash.events.*;

    [SWF(width="1000", height="600", backgroundColor="#cccccc", frameRate="30")]
    public class Main extends Sprite {
        public static var context:Context;
	public function Main() {
	    if (stage) init();
	    else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        public function init(event:MouseEvent = null):void {
            Context.init(this);
        }
    }
}