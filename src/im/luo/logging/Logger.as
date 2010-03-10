package im.luo.logging
{
    import flash.utils.getQualifiedClassName;
    public class Logger {
        protected var clazz:String;

        public function Logger(cls:*) {
            clazz = typeof cls == 'string' ? cls : getQualifiedClassName(cls); 
        }

        public static function getLogger(cls:*):Logger {
            return LoggerFactory.makeNewLoggerInstance(cls);
        }

        public function debug(... args):void {};

        public static function debug(... args):void {
            LoggerFactory.makeNewLoggerInstance("t").debug(args);
        };
    }
}
