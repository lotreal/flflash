package
{
    import flash.events.*;
    import im.luo.logging.Logger;
    import flf.flatland.game.PlayerHotkey;
    
    public class S2KBController extends PlayerHotkey {
        private var logger:Logger = Logger.getLogger(this);
        
        override public function update(e:Event):void {
            if (kb.pressed("W")) {
                _role.strafeNorth(kb.timePressed("W"));
            }
            if (kb.pressed("S")) {
                _role.strafeSouth(kb.timePressed("S"));
            }
            if (kb.pressed("A")) {
                _role.strafeEast(kb.timePressed("A"));
            }
            if (kb.pressed("D")) {
                _role.strafeWest(kb.timePressed("D"));
            }
            if (kb.pressed("RIGHT")) {
                _role.turnRight();
            }
            if (kb.pressed("LEFT")) {
                _role.turnLeft();
            }
        }

        override public function toString():String {
            return "W: 上; S: 下; A: 左; D: 右.   方向键左: 左转; 方向键右: 右转. "
        };

    }
}
