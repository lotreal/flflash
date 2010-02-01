package flf.flatland.fx
{
    import im.luo.logging.Logger;
    import flash.events.Event;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import im.luo.geom.Vector2D;
    import im.luo.game.Camera;
    
    public class Peng2 {
        private var _logger:Logger = Logger.getLogger(this);
        private var camera:Camera = Context.instance.camera;
        private var peng:MovieClip;
        public function Peng2(position:Vector2D) {
            peng = camera.addChild(
                new (Context.instance.loader.getDefinitionOf("PlayerCE"))()) as MovieClip;
	    peng.addEventListener("collover", destroy);
            peng.x = camera.rx(position.x);
            peng.y = camera.ry(position.y);

        }

        public function destroy(event:Event = null):void {
	    peng.removeEventListener("collover", destroy);
	    peng.parent.removeChild(peng);
        }
    }
}
