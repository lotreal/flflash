package im.luo.logging
{
    public class LoggerFactory {
        public static function makeNewLoggerInstance(cls:*):Logger {
	    //if (logger == null) 
            //logger = new ScreenLogger(cls);
            var logger:Logger = new AlconLogger(cls);
	    return logger;
	}

        public function LoggerFactory():void {
        }
    }
}
