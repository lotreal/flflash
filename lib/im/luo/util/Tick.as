package im.luo.util
{
    import flash.display.Shape;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.utils.getTimer;
    import im.luo.events.TickEvent;
    
    [Event(name="tick",type="im.luo.events.TickEvent")]
    public class Tick extends EventDispatcher {
        private static var _instance:Tick = null;
        public static function get instance():Tick {
            return Tick.getInstance();
        }
        public static function getInstance():Tick {
            if (_instance == null) _instance = new Tick(new SingletonEnforcer());
            return _instance;
        }
        public function Tick(singleton_enforcer:SingletonEnforcer) {
            super();
	    var displayObject:Shape = new Shape();
	    displayObject.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        }

	private var prevTime:int;
	/**
	* 最大两帧间隔（防止待机后返回卡死） 
	*/
	static public var MAX_INTERVAL:int = 300;
	
	private final function enterFrameHandler(event:Event):void
	{
	    var nextTime:int = getTimer();
	    var interval:int;
	    if (prevTime == 0) {
	        interval = 0;
	    } else {
		interval = Math.min(nextTime - prevTime, MAX_INTERVAL);
		var e:TickEvent = new TickEvent(TickEvent.TICK, interval);
		dispatchEvent(e);
	    }

	    prevTime = nextTime;
	}
    }
}

// SingletonEnforcer
class SingletonEnforcer {}