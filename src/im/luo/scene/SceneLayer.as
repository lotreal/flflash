package im.luo.scene
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import im.luo.logging.Logger;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    import im.luo.role.IRole;

    public class SceneLayer extends SceneAbstract implements ISceneLayer {
        private var _logger:Logger = Logger.getLogger(this);

        protected var list:Vector.<DisplayObject>;
        
        public function SceneLayer(rect:Rectangle = null) {
            super(rect);
            list = new Vector.<DisplayObject>();
        }
        
        public virtual function destroy():void {}

        public function add(child:*):* {
            list.push(child);
            return child;
        }

        //public function addCharacter(character:IRole):* {
        //    add(character.face);
        //    return character;
        //}

        protected function inCamera(el:DisplayObject, rect:Rectangle):Boolean {
            return true;
        }

        public virtual function preShoot(container:DisplayObjectContainer, rectangle:Rectangle):void {}
        public virtual function shooting(container:DisplayObjectContainer, rectangle:Rectangle):void {}
        public virtual function postShoot(container:DisplayObjectContainer, rectangle:Rectangle):void {}
    }
}
