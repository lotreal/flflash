package
{
    import flash.events.*;
    import im.luo.logging.Logger;
    
    public class S2KBController extends RBPlayerA {
        private var _logger:Logger = Logger.getLogger(this);
        
        override public function update(e:Event):void {
            if (kb.pressed("W")) {
                _role.strafeNorth();
            }
            if (kb.pressed("S")) {
                _role.strafeSouth();
            }
            if (kb.pressed("A")) {
                _role.strafeEast();
            }
            if (kb.pressed("D")) {
                _role.strafeWest();
            }
            if (kb.pressed("RIGHT")) {
                _role.turnRight();
            }
            if (kb.pressed("LEFT")) {
                _role.turnLeft();
            }

        }
    }
}
