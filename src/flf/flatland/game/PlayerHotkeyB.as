package flf.flatland.game
{
    import flash.events.*;
    import im.luo.logging.Logger;
    
    public class PlayerHotkeyB extends PlayerHotkeyA {
        private var logger:Logger = Logger.getLogger(this);
        
        override public function play(e:Event):void {
            if (kb.pressed("W")) {
                role.strafeNorth(kb.timePressed("W"));
            }
            if (kb.pressed("S")) {
                role.strafeSouth(kb.timePressed("S"));
            }
            if (kb.pressed("A")) {
                role.strafeEast(kb.timePressed("A"));
            }
            if (kb.pressed("D")) {
                role.strafeWest(kb.timePressed("D"));
            }
            if (kb.pressed("RIGHT")) {
                role.turnRight();
            }
            if (kb.pressed("LEFT")) {
                role.turnLeft();
            }
        }

        override public function toString():String {
            return "W: 上; S: 下; A: 左; D: 右.   方向键左: 左转; 方向键右: 右转. "
        };

    }
}
