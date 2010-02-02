package im.luo.game 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import flf.flatland.game.Context;
    
    public class Camera implements ICamera {
        private static var _instance:Camera = null;
        public static function get instance():Camera {
            return Camera.getInstance();
        }
        public static function getInstance():Camera {
            if (_instance == null) _instance = new Camera(new SingletonEnforcer());
            return _instance;
        }

        public static const FIXED:String = "fixed";
        public static const FOLLOW:String = "follow";

        private var logger:Logger = Logger.getLogger(this);
        private var context:Context = Context.instance;

        private var shootMode:String = Camera.FIXED;
        private var followTarget:RoleAbstract;

        protected var screen:Sprite;

        public var scale:Number = 30;

        public function Camera(singleton_enforcer:SingletonEnforcer):void {
            _rectangle = new Rectangle(0, 0, context.width, context.height);
            debug();
        }

        private var _rectangle:Rectangle = null;
        public function get rectangle():Rectangle {
            return _rectangle;
        }
        public function set rectangle(value:Rectangle):void {
            _rectangle = value;
        }


        public function rx(x:Number):Number {
            return x * scale;
            if (shootMode == Camera.FOLLOW) {
                var c:Vector2D = followTarget.body.center;
                return x - c.x;
            } else {
                return x;
            }
        }

        public function ry(y:Number):Number {
            return y * scale;
            if (shootMode == Camera.FOLLOW) {
                var c:Vector2D = followTarget.body.center;
                return y - c.y;
            } else {
                return y;
            }
        }

        //public function shoot(e:Event):void {
        //    if (shootMode == Camera.FOLLOW) {
        //        var c:Vector2D = followTarget.actor.center;
        //        rotation=0; // If not, matrix starts wrong.
        //        var m:Matrix=transform.matrix;
        //        m.tx= (w/2 - c.x * 30);
        //        m.ty= (h/2 - c.y * 30);
        //        transform.matrix=m;
        //    }
        //}

        public function follow(role:RoleAbstract):void {
            shootMode = Camera.FOLLOW;
            followTarget = role;
            logger.debug('镜头跟随模式');
        }

        public function debug():void {
            logger.debug('初始化摄影机');
            logger.debug('view rect', rectangle);
        }

        public function preShoot(scene:IScene):void {
            screen = new Sprite();
            context.root.addChild(screen);

            for (var i:int = 0, l:int = scene.layers.length; i < l; i++) {
                scene.layers[i].preShoot(screen, this.rectangle);
            }
        }

        public function shooting(scene:IScene):void {
            for (var i:int = 0, l:int = scene.layers.length; i < l; i++) {
                scene.layers[i].shooting(screen, this.rectangle);
            }
        }

        public function postShoot(scene:IScene):void {
            for (var i:int = 0, l:int = scene.layers.length; i < l; i++) {
                scene.layers[i].postShoot(screen, this.rectangle);
            }
        }

        public function add(child:*):* {
            return screen.addChild(child);
        }
    }
}
// SingletonEnforcer
class SingletonEnforcer {}
