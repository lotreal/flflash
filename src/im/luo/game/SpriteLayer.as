package im.luo.game
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import im.luo.logging.Logger;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    
    public class SpriteLayer extends SceneLayer implements ISceneLayer {
        protected var screen:Sprite;
        private var _logger:Logger = Logger.getLogger(this);

        public function SpriteLayer() {
            super();
        }

        override public function preShoot(container:DisplayObjectContainer, rectangle:Rectangle):void {
            screen = new Sprite();
            for (var i:int = 0, n:int = list.length; i < n; i++) {
                var el:DisplayObject = list[i];
                if (inCamera(el, rectangle)) screen.addChild(el);
            }
            container.addChild(screen);
        }
    }
}