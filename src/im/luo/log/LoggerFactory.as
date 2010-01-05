package im.luo.log
{
    public class LoggerFactory {
	private static var logger:Logger = null;
        public static function makeNewLoggerInstance(cls:*):Logger {
	    //if (logger == null) 
            logger = new Logger(cls);
	    return logger;
	}

        public function LoggerFactory():void {
        }
    }
}
