package im.luo.util
{
    import flash.display.Shape;
    import flash.events.Event;
    import flash.utils.getTimer;
    
    import im.luo.events.TickEvent;
    import ghostcat.util.core.Singleton;
    
    [Event(name="tick",type="im.luo.events.TickEvent")]
    public class Tick extends Singleton
    {
	private var prevTime:int;//上次记录的时间
	
	static public function get instance():Tick
	{
	    return Singleton.getInstanceOrCreate(Tick) as Tick;
	}
	
	/**
	* 全局默认帧频
	*/
	static public var frameRate:Number = NaN;
	
	/**
	* 最大两帧间隔（防止待机后返回卡死） 
	*/
	static public var MAX_INTERVAL:int = 300;
	
	public function Tick()
	{
	    var displayObject:Shape = new Shape();
	    displayObject.addEventListener(Event.ENTER_FRAME,enterFrameHandler);
	}
	
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
