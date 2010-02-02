package im.luo.game
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import im.luo.logging.Logger;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    import flash.display.Bitmap;
    import flash.display.BitmapData;

    public class TileLayer extends SceneLayer implements ISceneLayer {
        protected var screen:Bitmap;
        private var _logger:Logger = Logger.getLogger(this);

        public function TileLayer() {
            super();
        }

        override public function preShoot(container:DisplayObjectContainer, rectangle:Rectangle):void {
            var data:BitmapData = new BitmapData(rectangle.width, rectangle.height, true);
            for (var i:int = 0, n:int = list.length; i < n; i++) {
                var el:DisplayObject = list[i];
                if (inCamera(el, rectangle)) data.draw(el);
            }
            screen = new Bitmap(data);
            container.addChild(screen);
        }
    }
}