package im.luo.logging
{
    import flash.utils.getQualifiedClassName;
    public class Logger {
        protected var clazz:String;

        public function Logger(cls:*) {
            clazz = getQualifiedClassName(cls);
        }

        public static function getLogger(cls:*):Logger {
            return LoggerFactory.makeNewLoggerInstance(cls);
        }

        public virtual function debug(... args):void {};
    }
}
