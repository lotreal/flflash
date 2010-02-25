package im.luo.scene
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import im.luo.logging.Logger;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    import flash.geom.Matrix;
    import im.luo.role.IRole;
    
    /**
     * Sprite 图层，用于搭建 Scene。 
     */
    public class SpriteLayer extends SceneLayer implements ISceneLayer {
        protected var screen:Sprite;
        private var _logger:Logger = Logger.getLogger(this);

        public function SpriteLayer(rect:Rectangle = null) {
            super(rect);
            screen = new Sprite();
        }

        override public function destroy():void
        {
            screen.parent.removeChild(screen);
        }
            
        override public function preShoot(container:DisplayObjectContainer, rect:Rectangle):void {
            super.preShoot(container, rect);
            for (var i:int = 0, n:int = list.length; i < n; i++) {
                var el:DisplayObject = list[i];
                if (inCamera(el, rect) && (! onScreen[i]) ) screen.addChild(el);
                onScreen[i] = true;
            }

            container.addChild(screen);
        }

        override public function shooting(container:DisplayObjectContainer, rect:Rectangle):void {
            super.shooting(container, rect);
            for (var i:int = 0, n:int = list.length; i < n; i++) {
                var el:DisplayObject = list[i];
                if (inCamera(el, rect) && (! onScreen[i]) ) screen.addChild(el);
                onScreen[i] = true;
            }
            var m:Matrix=screen.transform.matrix;
            m.tx = rect.x * -1;
            m.ty = rect.y * -1;
            screen.transform.matrix=m;
        }
    }
}