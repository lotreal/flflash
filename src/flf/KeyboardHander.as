package flf
{
    import flash.events.*;

    public class KeyboardHander extends EventDispatcher {
	private static var _instance:KeyboardHander = null;
        public static function get instance():KeyboardHander {
	    if (_instance == null) _instance = new KeyboardHander(new SingletonEnforcer());
	    return _instance;
	}

        public var keys:Vector.<Boolean> = new Vector.<Boolean>(256);
        private var context:Context = Context.instance;
        public function KeyboardHander(singleton_enforcer:SingletonEnforcer):void {
            context.stage.addEventListener(KeyboardEvent.KEY_DOWN,
                function(e:KeyboardEvent):void { keys[e.keyCode] = true; } );
            context.stage.addEventListener(KeyboardEvent.KEY_UP,
                function(e:KeyboardEvent):void { keys[e.keyCode] = false; } );
        }
    }
}
// SingletonEnforcer
class SingletonEnforcer {}