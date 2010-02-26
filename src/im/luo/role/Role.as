package im.luo.role
{
    import flash.display.DisplayObjectContainer;
    import flash.events.EventDispatcher;
    import flash.geom.Rectangle;
    
    import im.luo.action.IRoleAction;
    import im.luo.actor.IActor;
    import im.luo.face.Face;
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import im.luo.scene.IScene;
    import im.luo.scene.ISceneLayer;
    import im.luo.staff.Context;
    import im.luo.ui.ITextPanel;
    import im.luo.util.Tags;
    import im.luo.vw.RoleEvent;
    import im.luo.vw.World;
    
    /**
     * 角色具备演员（身体）和外观两大属性。
     * @TODO 进一步解耦 Actor , actor = World.newActor
     * @author Lot
     * 
     */    
    public class Role extends EventDispatcher implements IRole {
        // 角色位置，单位为像素
        public var x:int;
        public var y:int;

        public var context:Context = Context.instance;

        private var _scene:IScene = null;
        public function get scene():IScene {
            return _scene;
        }
        public function set scene(value:IScene):void {
            _scene = value;
        }

        public var _sceneLayer:ISceneLayer;
        public function get sceneLayer():ISceneLayer {
            return _sceneLayer;
        }
        public function set sceneLayer(value:ISceneLayer):void {
            _sceneLayer = value;
        }
        
        // 角色信息显示面板，目前为调试用
        protected var uiInfo:ITextPanel;

        public static var UUID_SEED:int = 100;
        public var _uuid:int = 0;
        public function get uuid():int
        {
            return _uuid;
        }
        
        public function set uuid(value:int):void
        {
            _uuid = value;
        }
        /**
        * @parm name 角色名
        */
        public function Role(name:String) {
            this.name = name;
            //this.x = x;
            //this.y = y;
            uuid = UUID_SEED++;
        }

        private var _state:Tags = new Tags();
        public function get state():Tags {
            return _state;
        }
        public function set state(value:Tags):void {
            _state = value;
        }
        
        // 组别，为 Tag 方式，一个角色可以有多个分组
        private var _groups:Tags = new Tags();
        public function get groups():Tags {
            return _groups;
        }
        public function set groups(value:Tags):void {
            _groups = value;
        }

        public function get name():String {
            return _name;
        }

        public function set name(value:String):void {
            _name = value;
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
            actor.initPosition(value);
        }

        public function postShoot(container:DisplayObjectContainer, rectangle:Rectangle):void {};
        
        public function preShoot(container:DisplayObjectContainer, rectangle:Rectangle):void {
            //uiInfo = UI.textPanel(position, 100, 100, 12, 0x0000);
            //uiInfo.content = toString();
        };
        
        public function shooting(container:DisplayObjectContainer, rectangle:Rectangle):void {
            //play();
            //uiInfo.position = position;
            //uiInfo.content = toString();
        };
        
        override public function toString():String {
            return '';
            return 'T:' + type + '\n' 
                + 'N:' + name + '\n'
                ;
        }
        
        // 角色在 play 函数里更新自己的坐标，外观等
        public function play():void {
            if (action != null) action.play();
            actor.play();
            if (face != null) face.update();
        }

        public function destroy():void {
            var event:RoleEvent = new RoleEvent(World.REMOVEROLE);
            event.role = this;
            this.dispatchEvent(event);
            
            if (uiInfo != null) uiInfo.destroy();
            if (face != null) face.destroy();
            if (action != null)
            {
                action.destroy();
                action = null;
            }

            actor.destroy();
            _logger.debug(this.name, "destroy");
        }

        private var _logger:Logger = Logger.getLogger(this);
        private var _action:IRoleAction = null;
        private var _actor:IActor = null;
        private var _face:Face = null;
        private var _type:String = "unknown type";
        private var _name:String = "unknown name";
    }
}
