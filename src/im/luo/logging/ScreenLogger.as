package im.luo.logging
{
    import im.luo.util.Debugger;

    public class ScreenLogger extends Logger {
        public function ScreenLogger(cls:*):void {
            super(cls);
        }
        override public function debug(... args):void {
            var str:String = "";
            for (var i:int=0; i<args.length; i++) str += String(args[i]) + "; ";
            trace(clazz+'#'+str);

            Debugger.instance.print(clazz+'#'+str);
        }
    }
}
