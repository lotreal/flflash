package
{
    import flash.events.*;
    public class RBPlayerA extends EventDispatcher implements IRoleBehaviour {
        public var _actor:Actor;
        public function set actor(a:Actor):void {_actor = a};

        public var kb:Keyboard;

        public function RBPlayerA():void {
            kb = Keyboard.instance;
        }

        public function run():void {
            _actor.addEventListener(Event.ENTER_FRAME, update);
        }

        public function update(e:Event):void {
            if (kb.justPressed("LEFT")) {
                _actor.turnLeft();
            }
            if (kb.justPressed("UP")) {
                _actor.forward();
            }
            if (kb.pressed("RIGHT")) {
                _actor.turnRight();
            }
            if (kb.pressed("DOWN")) {
                _actor.backward();
            }
            //if (kb.justPressed[78]) { // N
            //    levelUp();
            //}
            //if (kb.justPressed[77]) { // M
            //    levelDown();
            //}
        }
    }
}
