package flf.flatland.game
{
    import flash.display.*;
    import im.luo.logging.Logger;
    import flash.events.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import flf.flatland.meta.Creature;
    import flf.flatland.role.Player;
    import im.luo.game.IRoleBehaviour;
    import im.luo.util.Keyboard;
    import flf.flatland.scene.PlayScene;

    public class PlayerHotkeyA extends EventDispatcher implements IRoleBehaviour {
        private var logger:Logger = Logger.getLogger(this);

        protected var scene:PlayScene;
        protected var role:Player;
        protected var kb:Keyboard;
        protected var context:Context = Context.instance;

        public function PlayerHotkeyA(scene:PlayScene, role:Player):void {
            this.kb = Keyboard.instance;
            this.scene = scene;
            this.role = role;
        }

        public function play():void {
            logger.debug("play");
            if (kb.pressed("LEFT")) {
                role.turnLeft();
            }
            if (kb.pressed("UP")) {
                role.forward(kb.timePressed("UP"));
            }
            if (kb.pressed("RIGHT")) {
                role.turnRight();
            }
            if (kb.pressed("DOWN")) {
                role.backward(kb.timePressed("DOWN"));
            }
        }

        override public function toString():String {
            return "上\下\左\右 方向键分别为: 前进; 后退; 左转; 右转. "
        };
    }
}
