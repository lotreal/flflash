package 
{
    import flash.events.*;
    import im.luo.logging.Logger;
	import flf.flatland.meta.Creature;
	import flf.flatland.game.PlayerHotkey;

    public class Director extends EventDispatcher {
        public static const ACTION:String = "action";

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
        public var player1:Creature = null;
        public var context:Context = Context.instance;

        public function Director(singleton_enforcer:SingletonEnforcer):void {
            context.stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
        }

        public function action():void {
            dispatchEvent(new Event(Director.ACTION));
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
                if (pcf == 1) player1.controller = new S2KBController();
                else player1.controller = new PlayerHotkey();
            }

	    if(c == KeyCode.D) {
            }

        }

    }
}

// SingletonEnforcer
class SingletonEnforcer {}
