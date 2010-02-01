package
{
    import flash.events.Event;
    import flash.display.Sprite;
    import im.luo.game.Camera;

    public class Appearance extends Sprite {
        public var vision:Vision;
        public var role:*;
        public var context:Context = Context.instance;
        public var camera:Camera = context.camera;

        public function Appearance(role:Role) {
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