package flf.flatland.action
{
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    
    import flash.display.*;
    import flash.events.*;
    
    import flf.flatland.role.Player;
    import flf.flatland.scene.PlayScene;
    
    import im.luo.action.KeyboardAction;
    import im.luo.logging.Logger;
    
    public class PlayerHotkeyA extends KeyboardAction {
        public function PlayerHotkeyA(scene:PlayScene, role:Player):void {
            super(scene, role);
        }
        
        override public function play():void {
            //_logger.debug("play");
            if (keyboard.pressed("LEFT")) {
                role.turnLeft();
            }
            if (keyboard.pressed("UP")) {
                role.forward(keyboard.timePressed("UP"));
            }
            if (keyboard.pressed("RIGHT")) {
                role.turnRight();
            }
            if (keyboard.pressed("DOWN")) {
                role.backward(keyboard.timePressed("DOWN"));
            }
        }

        override public function destroy():void {}
        
        override public function toString():String {
            return "上\下\左\右 方向键分别为: 前进; 后退; 左转; 右转. "
        };
        
        private var _logger:Logger = Logger.getLogger(this);
    }
}