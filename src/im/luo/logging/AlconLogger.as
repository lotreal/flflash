package im.luo.logging
{
    import com.hexagonstar.util.debug.Debug;
    import flash.utils.getTimer;

    public class AlconLogger extends Logger {
        public function AlconLogger(cls:*):void {
            super(cls);
        }
        override public function debug(... args):void {
            var str:String = "";
            for (var i:int=0; i<args.length; i++) str += String(args[i]) + "; ";

            Debug.trace(getTimer()+':'+clazz+'#'+str);
        }
    }
}
