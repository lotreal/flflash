package im.luo.scene
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import im.luo.logging.Logger;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    import flash.geom.Matrix;
    
    public class SpriteLayer extends SceneLayer implements ISceneLayer {
        protected var screen:Sprite;
        private var logger:Logger = Logger.getLogger(this);

        public function SpriteLayer(rect:Rectangle = null) {
            super(rect);
        }

        override public function preShoot(container:DisplayObjectContainer, rect:Rectangle):void {
            screen = new Sprite();
            for (var i:int = 0, n:int = list.length; i < n; i++) {
                var el:DisplayObject = list[i];
                if (inCamera(el, rect)) screen.addChild(el);
            }

            container.addChild(screen);
        }

        override public function shooting(container:DisplayObjectContainer, rect:Rectangle):void {
            var m:Matrix=screen.transform.matrix;
            m.tx = rect.x * -1;
            m.ty = rect.y * -1;
            screen.transform.matrix=m;
        }
    }
}