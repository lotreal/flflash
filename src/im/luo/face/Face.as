package im.luo.face
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Matrix;
    
    import im.luo.geom.Vector2D;
    import im.luo.role.IRole;
    import im.luo.staff.Context;

    import im.luo.logging.Logger;

    // Face 类提供角色的造型描述，用来把角色显示到屏幕上。
    public class Face extends Sprite {
        public var role:*;
        public var context:Context = Context.instance;
        private var logger:Logger = Logger.getLogger(this);
        public function Face(role:IRole) {
            this.role = role;
        }

        public function paint():void {
        }

        public function repaint():void {
        }

        // 根据角色的位置和角度更新外观的位置和角度
        public function update(e:Event = null):void {
            var position:Vector2D = role.actor.position;
            
            rotation = 0; // If not, matrix starts wrong.
            var m:Matrix; // = new Matrix(1,0,0,1, position.x, position.y);
            m = transform.matrix;
            m.a = 1;
            m.d = 1;
            m.rotate(role.actor.angle);
            m.tx = position.x;
            m.ty = position.y;
            transform.matrix = m;
            //logger.debug(m);
        }

        public function destroy():void {
            if (parent != null) parent.removeChild(this);
        }
    }
}