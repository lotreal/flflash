package im.luo.scene
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    
    import im.luo.logging.Logger;
    import im.luo.role.IRole;

    public class SceneLayer extends SceneAbstract implements ISceneLayer {
        private var _logger:Logger = Logger.getLogger(this);

        protected var list:Vector.<DisplayObject>;
        protected var onScreen:Vector.<Boolean>;
        
        public function SceneLayer(rect:Rectangle = null) {
            super(rect);
            list = new Vector.<DisplayObject>();
            onScreen = new Vector.<Boolean>();
        }
        
        public virtual function destroy():void {}
        
        public function get roles():Vector.<IRole> {
            return _roles;
        }
        
        public function set roles(value:Vector.<IRole>):void {
            _roles = value;
        }
        
        public function add(child:*):* {
            list.push(child);
            onScreen.push(false);
            return child;
        }

        //public function addCharacter(character:IRole):* {
        //    add(character.face);
        //    return character;
        //}

        protected function inCamera(el:DisplayObject, rect:Rectangle):Boolean {
            return true;
        }

        public function preShoot(container:DisplayObjectContainer, rectangle:Rectangle):void 
        {
            for (var i:int = 0, n:int = roles.length; i < n; i++) {
                roles[i].preShoot(container, rect);
            }
        }
        
        public function shooting(container:DisplayObjectContainer, rectangle:Rectangle):void
        {
            for (var i:int = 0, n:int = roles.length; i < n; i++) {
                roles[i].shooting(container, rect);
            }
        }
        
        public function postShoot(container:DisplayObjectContainer, rectangle:Rectangle):void
        {
            for (var i:int = 0, n:int = roles.length; i < n; i++) {
                roles[i].postShoot(container, rect);
            }
        }
        
        private var _roles:Vector.<IRole> = new Vector.<IRole>();
    }
}
