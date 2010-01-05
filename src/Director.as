package 
{
    import flash.events.*;
    import im.luo.log.Logger;
    public class Director extends EventDispatcher {
        public static const ACTION:String = "action";

        private static var _instance:Director = null;
        public static function get instance():Director {
            return Director.getInstance();
        }
        public static function getInstance():Director {
            if (_instance == null) _instance = new Director(new SingletonEnforcer());
            return _instance;
        }

        private var logger:Logger = Logger.getLogger(this);
        public function Director(singleton_enforcer:SingletonEnforcer):void {
        }

        public function action():void {
            dispatchEvent(new Event(Director.ACTION));
        }
    }
}

// SingletonEnforcer
class SingletonEnforcer {}
