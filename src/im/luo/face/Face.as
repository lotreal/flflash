package im.luo.face
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Matrix;
    
    import im.luo.geom.Vector2D;
    import im.luo.role.IRole;
    import im.luo.staff.Context;

    public class Face {
        public var role:*;
        public var render:Sprite = new Sprite();
        public var context:Context = Context.instance;

        public function Face(role:IRole) {
            this.role = role;
        }

        public function paint():void {
        }

        public function repaint():void {
        }

        public function update(e:Event = null):void {
            var position:Vector2D = role.actor.position;
            var rotation:Number = role.actor.angle;
            
            render.rotation = 0; // If not, matrix starts wrong.
            var m:Matrix;
            m = render.transform.matrix;
            m.rotate(rotation);
            m.tx = position.x;
            m.ty = position.y;
            render.transform.matrix = m;
        }

        public function destroy():void {
            if (render.parent != null) render.parent.removeChild(render);
        }
    }
}