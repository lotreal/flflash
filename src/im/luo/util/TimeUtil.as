package im.luo.util
{
    import flash.utils.Timer;
    import flash.events.TimerEvent;

    public class TimeUtil
    {
        public function TimeUtil()
        {
        }
        
        // 延迟时间（以毫秒为单位）。
        public static function delay(delay:Number, func:Function):void {
            var myTimer:Timer = new Timer(delay, 1);
            myTimer.addEventListener("timer", function timerHandler(event:TimerEvent):void{ func(); } );
            myTimer.start();
        }
    }
}