package flf {
    import flash.events.*;
    import im.luo.utils.*;

    public class KeyboardController implements IDollController {
        private var doll:Doll;
        public function KeyboardController(doll:Doll):void {
            this.doll = doll;
            doll.addEventListener(Event.ENTER_FRAME, run);
        }

        public function run(e:Event):void {
            var context:Context = Context.getInstance();
            var keyMapper:KeyMapper = context.keyMapper;
            if (keyMapper.pressed(0)) {
                doll.turnLeft();
            }
            if (keyMapper.pressed(1)) {
                doll.forward();
            }
            if (keyMapper.pressed(2)) {
                doll.turnRight();
            }
            if (keyMapper.pressed(3)) {
                doll.backward();
            }
            if (keyMapper.pressed(4)) {
                context.console.print('level up');
                doll.levelUp();
            }
            if (keyMapper.pressed(5)) {
                context.console.print('level down');
                doll.levelDown();
            }

        }
    }
}
