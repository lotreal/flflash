package im.luo.role
{
    import im.luo.logging.Logger;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import im.luo.ui.UI;
    import im.luo.staff.Context;
    import im.luo.geom.Vector2D;
    import im.luo.actor.IActor;
    import im.luo.face.Face;
    import im.luo.action.IRoleAction;
    import flash.geom.Rectangle;
    import im.luo.ui.ITextPanel;
    
    public class RoleAbstract implements IRole {
        public var x:int;
        public var y:int;

        public var context:Context = Context.instance;

        protected var uiInfo:ITextPanel;

        public function RoleAbstract(name:String, x:int, y:int) {
            this.name = name;
            this.x = x;
            this.y = y;
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
            UI.instance.tips("当前操作方案: "+ value.toString() +" [切换操作方案: 空格键]");
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
            actor.play();
            if (action != null) action.play();
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
