package im.luo.face
{
    import flash.display.Sprite;
    import flash.events.Event;
    
    import im.luo.role.IRole;

    public class Face {
        public var role:*;
        public var render:Sprite = new Sprite();

        public function Face(role:IRole) {
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