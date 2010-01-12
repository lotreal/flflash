package
{
    import flash.events.Event;
    import flash.display.Sprite;
    public class Looks extends Sprite {
        public var vision:Vision;
        public var role:Role;
        public var context:Context = Context.instance;
        public var camera:Camera = context.camera;

        public function Looks(role:Role) {
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