package flf.flatland.game 
{
    import flash.events.*;
    import flf.flatland.role.Creature;
    import im.luo.logging.Logger;
    import im.luo.util.Tick;
    import im.luo.events.TickEvent;
    import im.luo.util.Keyboard;
    import im.luo.util.KeyCode;
    import flf.flatland.scene.PlayScene;
    import im.luo.game.ICamera;
    import im.luo.game.IScene;
    import im.luo.game.DirectorAbstract;
    import im.luo.game.Camera;

    public class Director extends DirectorAbstract {
        private static var _instance:Director = null;
        public static function get instance():Director {
            return Director.getInstance();
        }
        public static function getInstance():Director {
            if (_instance == null) _instance = new Director(new SingletonEnforcer());
            return _instance;
        }
        
        private var logger:Logger = Logger.getLogger(this);
        
        public var keyboard:Keyboard = Keyboard.instance;
        public var context:Context = Context.instance;
        public var player1:Creature = null;
        
        public function Director(singleton_enforcer:SingletonEnforcer):void {
            // TODO -> keyboard process
            context.stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
            
            camera = Camera.instance;
            scene = new PlayScene();
            scene.build();

            action();
        }
        
        private var pcf:int = 0;
        public function handleKeyUp(event:KeyboardEvent):void {
            var c:int  = event.keyCode;
            if(c == KeyCode.N) {
                player1.levelUp();
            }
            
            if(c == KeyCode.M) {
                player1.levelDown();
            }
            
            if(c == KeyCode.SPACEBAR) {
                pcf++;
                pcf = pcf > 1 ? 0 : pcf;
                //if (pcf == 1) player1.behaviour = new S2KBController();
                //else player1.behaviour = new PlayerHotkey();
            }
            
            if(c == KeyCode.D) {
            }
        }
    }
}

// SingletonEnforcer
class SingletonEnforcer {}
