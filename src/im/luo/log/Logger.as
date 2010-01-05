package im.luo.log
{
    import flash.utils.getQualifiedClassName;
    import im.luo.ui.Debugger;

    public class Logger {
        private var clazz:String;
        public function Logger(cls:*):void {
            clazz = getQualifiedClassName(cls);
        }

        public static function getLogger(cls:*):Logger {
            return LoggerFactory.makeNewLoggerInstance(cls);
        }

        public function debug(... args):void {
            var str:String = "";
            for (var i:int=0; i<args.length; i++) str += String(args[i]) + "; ";
            trace(clazz+'#'+str);

            Debugger.instance.print(clazz+'#'+str);
        }

    }
}
