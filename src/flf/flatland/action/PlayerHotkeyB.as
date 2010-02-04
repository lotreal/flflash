package flf.flatland.game
{
    import flash.events.*;
    import im.luo.logging.Logger;
    
    public class PlayerHotkeyB extends ActionAbstract {
        public function PlayerHotkeyB(scene:PlayScene, role:Player):void {
            super(scene, role);
        }
        
        override public function play(e:Event):void {
            if (keyboard.pressed("W")) {
                role.strafeNorth(keyboard.timePressed("W"));
            }
            if (keyboard.pressed("S")) {
                role.strafeSouth(keyboard.timePressed("S"));
            }
            if (keyboard.pressed("A")) {
                role.strafeEast(keyboard.timePressed("A"));
            }
            if (keyboard.pressed("D")) {
                role.strafeWest(keyboard.timePressed("D"));
            }
            if (keyboard.pressed("RIGHT")) {
                role.turnRight();
            }
            if (keyboard.pressed("LEFT")) {
                role.turnLeft();
            }
        }

        override public function toString():String {
            return "W: 上; S: 下; A: 左; D: 右.   方向键左: 左转; 方向键右: 右转. "
        };
        
        private var _logger:Logger = Logger.getLogger(this);
    }
}
