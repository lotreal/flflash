package im.luo.game
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import im.luo.logging.Logger;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;

    public class SceneLayer implements ISceneLayer {
        private var logger:Logger = Logger.getLogger(this);

        protected var list:Vector.<DisplayObject>;
        
        public function SceneLayer() {
            list = new Vector.<DisplayObject>();
        }

        public function add(child:*):* {
            list.push(child);
            return child;
        }

        public function addCharacter(character:RoleAbstract):* {
            add(character.appearance);
            return character;
        }

        protected function inCamera(el:DisplayObject, rect:Rectangle):Boolean {
            return true;
        }

        public virtual function preShoot(container:DisplayObjectContainer, rectangle:Rectangle):void {}
        public virtual function shooting(container:DisplayObjectContainer, rectangle:Rectangle):void {}
        public virtual function postShoot(container:DisplayObjectContainer, rectangle:Rectangle):void {}
    }
}
