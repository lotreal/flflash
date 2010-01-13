package
{
    import flash.display.*;
    import im.luo.logging.Logger;
    import flash.events.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;

    public class RBPlayerA extends EventDispatcher implements IRoleBehaviour {
        private var logger:Logger = Logger.getLogger(this);

        public var _role:GladiatorRole;
        public function set role(value:Role):void {_role = GladiatorRole(value)};

        public var kb:Keyboard;
        public var context:Context = Context.instance;

        public function RBPlayerA():void {
            kb = Keyboard.instance;
        }

        public function run():void {
            context.camera.addEventListener(Event.ENTER_FRAME, update);
        }

        public function destroy():void {
            context.camera.removeEventListener(Event.ENTER_FRAME, update);
        }

        public function update(e:Event):void {
            if (kb.pressed("LEFT")) {
                _role.turnLeft();
            }
            if (kb.pressed("UP")) {
                _role.forward();
            }
            if (kb.pressed("RIGHT")) {
                _role.turnRight();
            }
            if (kb.pressed("DOWN")) {
                _role.backward();
            }
        }

    }
}
