package 
{
    import flash.display.*;
    import flash.events.*;
    import im.luo.logging.Logger;
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

        public var width:int = 997 * 2;
        public var height:int = 600 * 2;

        public function Scenario(singleton_enforcer:SingletonEnforcer) {
            scenery();
            var player1:GladiatorRole = new GladiatorRole(20, 12);
            player1.controller = new RBPlayerA();
            player1.run();
            Director.instance.player1 = player1;

            var npc:GladiatorRole;
            var x:Number, y:Number;
            for (var i:int = 0; i < 20; i++) {
                x = Math.random() * width / 30;
                y = Math.random() * height / 30;

                npc = new NpcGladiatorRole(x, y);
                npc.run();
            }

            //var player1:Fighter = new Fighter(6, 6);
            //player1.action = new KeyboardAction();
            //addRole(player1);

            //var a:Actor = new Actor(10, 6, new RBPlayerA());
            context.camera.follow(player1);
            
            //var b:Actor = new Actor(20, 6);
            logger.debug('建立场景');
            //var scene:SceneFight = new SceneFight();
        }

        public function scenery():void {
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

