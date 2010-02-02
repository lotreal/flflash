package im.luo.game
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flf.flatland.game.Context;

    public class Face extends Sprite {
        public var role:*;
        public var context:Context = Context.instance;
        public var camera:Camera = context.camera;

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