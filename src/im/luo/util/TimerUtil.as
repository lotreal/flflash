package im.luo.util
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    import im.luo.logging.Logger;
    
    public class TimerUtil extends EventDispatcher
    {
        private var count:Number;
        private var step:Number;
        
        private var interval:int = 1000;
        private var repeat:int;
        
        private var myTimer:Timer;
        private var countDate:Date;
        
        private var _logger:Logger = Logger.getLogger(this);
        
        /*
        * example: 
        * tu = new TimerUtil(100 * 1000)  # 计时100秒，间隔 1000 毫秒。
        * tu = new TimerUtil(100 * 1000, 1000, true)  # 倒计时100秒，间隔 1000 毫秒。 
        */
        public function TimerUtil(count:Number, interval:int=1000, reverse:Boolean=false)
        {
            this.repeat = count / interval;

            this.count = count + (new Date(2000, 0, 1, 0, 0, 0, 0)).getTime();
            this.interval = interval;
            
            this.step = (reverse ? -1 : 1) * interval;
        }
        
        public function start():void
        {
            myTimer = new Timer(interval, repeat);
            myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
            myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
            myTimer.start();
        }
        
        public function stop():void
        {
            myTimer.stop();
        }
        
        public function getTimeString():String
        {
            countDate = new Date(count);
            var _h:String =("0"+countDate.getHours()).substr(-2);
            var _m:String =("0"+countDate.getMinutes()).substr(-2);
            var _s:String =("0"+countDate.getSeconds()).substr(-2);
            return _m + ":" + _s;
        }
        
        private function timerHandler(event:TimerEvent):void
        {
            count += step;
            dispatchEvent(event);
        }
        
        private function completeHandler(event:TimerEvent):void {
            dispatchEvent(event);
        }

        // 延迟时间（以毫秒为单位）。
        public static function delay(delay:Number, func:Function):void {
            var myTimer:Timer = new Timer(delay, 1);
            myTimer.addEventListener("timer", function timerHandler(event:TimerEvent):void{ func(); } );
            myTimer.start();
        }
    }
}