package 
{
    import flash.events.*;
    import im.luo.log.Logger;
    public class Scenario extends EventDispatcher {
        private static var _instance:Scenario = null;
        public static function get instance():Scenario {
            return Scenario.getInstance();
        }
        public static function getInstance():Scenario {
            if (_instance == null) _instance = new Scenario(new SingletonEnforcer());
            return _instance;
        }

        private var logger:Logger = Logger.getLogger(this);
        private var context:Context = Context.instance;

        public function Scenario(singleton_enforcer:SingletonEnforcer) {
            var a:Actor = new Actor();
            a.behaviour = new RBPlayerA();
            context.camera.follow(a);
            
            var b:Actor = new Actor();
            logger.debug('建立场景');
            //var scene:SceneFight = new SceneFight();
        }
    }
}

// SingletonEnforcer
class SingletonEnforcer {}

