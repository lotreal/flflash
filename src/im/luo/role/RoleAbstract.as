package im.luo.role
{
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    
    import im.luo.action.IRoleAction;
    import im.luo.actor.IActor;
    import im.luo.face.Face;
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import im.luo.staff.Context;
    import im.luo.ui.ITextPanel;
    import im.luo.ui.UI;
    
    public class RoleAbstract implements IRole {
        // 角色位置，单位为像素
        public var x:int;
        public var y:int;

        public var context:Context = Context.instance;

        // 角色信息显示面板，目前为调试用
        protected var uiInfo:ITextPanel;

        /**
        * @parm name 角色名
        */
        public function RoleAbstract(name:String, x:int, y:int) {
            this.name = name;
            this.x = x;
            this.y = y;
        }

        // 分组 id，用于敌我判断。
        private var _groupid:int = 0;
        public function get groupid():int {
            return _groupid;
        }
        public function set groupid(value:int):void {
            _groupid = value;
        }

        public function get name():String {
            return _name;
        }

        public function set name(value:String):void {
            _name = value;
        }

        public function get type():String {
            return _type;
        }

        public function set type(value:String):void {
            _type = value;
        }
        
        private var _radius:Number;
        public function get radius():Number {
            return _radius;
        }
        
        public function set radius(value:Number):void {
            _radius = value;
        }
        
        public function get actor():IActor {
            return _actor;
        }

        public function set actor(value:IActor):void {
            _actor = value;
        }

        public function get face():Face {
            return _face;
        }

        public function set face(value:Face):void {
            _face = value;
        }

        public function get action():IRoleAction {
            return _action;
        }

        public function set action(value:IRoleAction):void {
            if (_action != null) _action.destroy();
            _action = value;
        }

        public function get position():Vector2D {
            return actor.position;
        }

        public function set position(value:Vector2D):void {
            actor.position = value;
        }

        public function postShoot(container:DisplayObjectContainer, rectangle:Rectangle):void {};
        
        public function preShoot(container:DisplayObjectContainer, rectangle:Rectangle):void {
            uiInfo = UI.textPanel(position, 100, 100, 12, 0x0000);
            uiInfo.content = toString();
        };
        
        public function shooting(container:DisplayObjectContainer, rectangle:Rectangle):void {
            uiInfo.position = position;
            uiInfo.content = toString();
        };
        
        public function toString():String {
            return '';
            return 'T:' + type + '\n' 
                + 'N:' + name + '\n'
                ;
        }
        
        public function play():void {
            if (action != null) action.play();
            actor.play();
            if (face != null) face.update();
        }

        public function destroy():void {
            if (uiInfo != null) uiInfo.destroy();

            if (face != null) face.destroy();
            if (action != null) action.destroy();
            actor.destroy();
        }

        private var _logger:Logger = Logger.getLogger(this);
        private var _action:IRoleAction = null;
        private var _actor:IActor = null;
        private var _face:Face = null;
        private var _type:String = "unknown type";
        private var _name:String = "unknown name";
    }
}
