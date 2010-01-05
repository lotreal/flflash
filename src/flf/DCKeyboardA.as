package flf
{
    import flash.events.*;
    import flash.ui.Keyboard;
    public class DCKeyboardA extends EventDispatcher implements IDollController {
        private var doll:Doll;
        private var kb:KeyboardHander;
        public function DCKeyboardA(d:Doll):void {
            kb = KeyboardHander.instance;
            doll = d;
        }

        public function action():void {
            doll.addEventListener(Event.ENTER_FRAME, run);
        }

        public function run(e:Event):void {
            //trace(kb.keys[Keyboard.LEFT]);
            if (kb.keys[Keyboard.LEFT]) {
                doll.turnLeft();
            }
            if (kb.keys[Keyboard.UP]) {
                doll.forward();
            }
            if (kb.keys[Keyboard.RIGHT]) {
                doll.turnRight();
            }
            if (kb.keys[Keyboard.DOWN]) {
                doll.backward();
            }
            if (kb.keys[78]) { // N
                doll.levelUp();
            }
            if (kb.keys[77]) { // M
                doll.levelDown();
            }
        }
    }
}
