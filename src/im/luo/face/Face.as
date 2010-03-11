package im.luo.face
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Matrix;
    
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import im.luo.role.IRole;
    import im.luo.staff.Context;

    // Face 类提供角色的造型描述，用来把角色显示到屏幕上。
    public class Face extends Sprite {
        public function Face(role:IRole) {
            this.role = role;
            addChildAt(body, 0);
        }

        public function paint():void {
        }

        public function repaint():void {
        }

        // 根据角色的位置和角度更新外观的位置和角度
        public function update(e:Event = null):void {
            position = role.actor.position;

            x = position.x;
            y = position.y;
            
            var m:Matrix;
            body.rotation = 0; // If not, matrix starts wrong.
            m = body.transform.matrix;
            m.a = 1;
            m.d = 1;
            m.rotate(role.actor.angle);
            body.transform.matrix = m;
            //logger.debug(m);
        }
        
        /**
         * 根据描述作出相应的表情，通常是播放动画 
         * @param desc 动画描述
         * 
         */        
        public function express(desc:String):void {}

        public function destroy():void
        {
            if (parent != null) parent.removeChild(this);
        }
        
        public function get ui():Sprite
        {
            if (_ui==null)
            {
                _ui = new Sprite();
                addChild(_ui);
            }
            return _ui;
        }
        
        public var role:IRole;
        public var context:Context = Context.instance;
        public var position:Vector2D = new Vector2D(0, 0);
        public var body:Sprite = new Sprite();
        public var _ui:Sprite = null;
        
        private var logger:Logger = Logger.getLogger(this);
    }
}