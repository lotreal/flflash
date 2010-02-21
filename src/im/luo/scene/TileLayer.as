package im.luo.scene
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import im.luo.logging.Logger;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.display.Bitmap;
    import flash.display.BitmapData;

    public class TileLayer extends SceneLayer implements ISceneLayer {
        protected var screen:Bitmap;
        protected var tile:BitmapData;
        protected var data:BitmapData;
        private var _logger:Logger = Logger.getLogger(this);

        public function TileLayer() {
            super();
        }

        override public function preShoot(container:DisplayObjectContainer, rect:Rectangle):void {
            var buffer:Sprite = new Sprite();
            for (var i:int = 0, n:int = list.length; i < n; i++) {
                var el:DisplayObject = list[i];
                if (inCamera(el, rect)) buffer.addChild(el);
            }

            tile = new BitmapData(buffer.width, buffer.height, true);
            tile.draw(buffer);

            var tileBuffer:Sprite = new Sprite();
            tileBuffer.graphics.beginBitmapFill(tile);
            tileBuffer.graphics.drawRect(0, 0, 750 * 2, 485 * 2);
            tileBuffer.graphics.endFill();

            tile = new BitmapData(750 * 2, 485 * 2, true);
            tile.draw(tileBuffer);

            _logger.debug("tile~~~~~~~~~~~");
            _logger.debug(tile.rect);
            data = new BitmapData(rect.width, rect.height, true);
            //data.setVector(data.rect, tile.getVector(rect));
            data.copyPixels(tile, rect, new Point(0, 0));

            screen = new Bitmap(data);
            container.addChild(screen);
        }

        override public function shooting(container:DisplayObjectContainer, rect:Rectangle):void {
            data.copyPixels(tile, rect, new Point(0, 0));
            //data.setVector(data.rect, tile.getVector(rect));
        }
    }
}