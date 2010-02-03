package im.luo.face
{
    import flash.events.Event;
    import flash.display.Sprite;

    import im.luo.role.RoleAbstract;

    public class Face {
        public var role:*;
        public var render:Sprite = new Sprite();

        public function Face(role:RoleAbstract) {
            this.role = role;
        }

        public function paint():void {
        }

        public function repaint():void {
        }

        public function update(e:Event = null):void {
        }

        public function destroy():void {
        }
    }
}