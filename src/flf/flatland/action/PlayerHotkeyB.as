package flf.flatland.action
{
    import flf.flatland.role.Player;
    import flf.flatland.scene.PlayScene;

    import im.luo.action.KeyboardAction;
    import im.luo.logging.Logger;
    import im.luo.motion.BasicMotion;
    
    public class PlayerHotkeyB extends KeyboardAction {
        public function PlayerHotkeyB(scene:PlayScene, role:Player):void {
            super(scene, role);
        }
        
        override public function play():void {
            if (keyboard.pressed("W") || keyboard.pressed("UP")) {
                BasicMotion.up(role);
            }
            if (keyboard.pressed("S") || keyboard.pressed("DOWN")) {
                BasicMotion.down(role);
            }
            if (keyboard.pressed("A") || keyboard.pressed("LEFT")) {
                BasicMotion.left(role);
            }
            if (keyboard.pressed("D") || keyboard.pressed("RIGHT")) {
                BasicMotion.right(role);
            }
        }

        override public function toString():String {
            return "W: 上; S: 下; A: 左; D: 右."
        };
        
        private var _logger:Logger = Logger.getLogger(this);
    }
}
