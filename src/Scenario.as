package 
{
    import flash.display.*;
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


            var a:Actor = new Actor(new RBPlayerA());
            context.camera.follow(a);
            
            var b:Actor = new Actor();
            logger.debug('建立场景');
            //var scene:SceneFight = new SceneFight();
        }

        public function bg():void {
            var map1:DisplayObject = context.camera.addChild(
                new (context.asset_loader.getDefinitionOf("Map1"))());
            var map2:DisplayObject = new (context.asset_loader.getDefinitionOf("Map2"))();
            map2.x = 997;
            context.camera.addChild(map2);
            var map3:DisplayObject = new (context.asset_loader.getDefinitionOf("Map3"))();
            map3.y = 600;
            context.camera.addChild(map3);
            var map4:DisplayObject = new (context.asset_loader.getDefinitionOf("Map4"))();
            map4.x = 997;
            map4.y = 600;
            context.camera.addChild(map4);

        }
    }
}

// SingletonEnforcer
class SingletonEnforcer {}

