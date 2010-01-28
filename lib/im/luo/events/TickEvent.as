package im.luo.events
{
    import flash.events.Event;
    
    public class TickEvent extends Event
    {
	public static const TICK:String="tick";
	
	/**
	* 两次发布事件的毫秒间隔
	*/		
	public var interval:int;
	
	/**
	* 用于Tick的发布事件
	* 
	* @param type	类型
	* @param interval	两次事件的毫秒间隔
	* 
	*/		
	public function TickEvent(type:String, interval:int, bubbles:Boolean=false, cancelable:Boolean=false) {
	    super(type, bubbles, cancelable);
            this.interval = interval;
	}
	
	public override function clone() : Event {
	    return new TickEvent(type, interval, bubbles, cancelable);
	}
    }
}