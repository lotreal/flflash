package
{
    import im.luo.logging.Logger;
    import flash.events.Event;
    import Box2D.Common.Math.b2Vec2;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    
    public class Peng2 {
        private var _logger:Logger = Logger.getLogger(this);
        private var camera:Camera = Context.instance.camera;
        private var peng:MovieClip;
        public function Peng2(position:b2Vec2) {
            peng = camera.addChild(
                new (Context.instance.asset_loader.getDefinitionOf("PlayerCE"))()) as MovieClip;
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
