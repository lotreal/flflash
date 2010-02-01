package im.luo.game 
{
    import flash.display.*;
    import flash.geom.*;
    import flash.events.*;
    import im.luo.logging.Logger;
    import Box2D.Common.Math.*;    

    import flash.utils.getTimer;
    import caurina.transitions.Tweener;
    import ghostcat.display.residual.ResidualScreen;
    import ghostcat.display.bitmap.BitmapScreen;
    import im.luo.geom.Vector2D;
    import im.luo.physics.box2d.box2dActor;
    
    public class Camera extends Sprite implements ICamera {
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

        public var screen:ResidualScreen;
        private var logger:Logger = Logger.getLogger(this);
        private var context:Context = Context.instance;

        private var shootMode:String = Camera.FIXED;
        private var followTarget:Role;

        public var scale:Number = 30;

        public function Camera(singleton_enforcer:SingletonEnforcer):void {
            context.root.addChild(this);
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

        private var actors:Vector.<box2dActor> = new Vector.<box2dActor>;
        public function observe(p_display:*):Vision {
            var vision:Vision = new Vision(this);
            //actors.push(p_display);
            //screen.addChild(vision);
            addChild(vision);
            return vision;
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

        public function follow(role:Role):void {
            shootMode = Camera.FOLLOW;
            followTarget = role;
            logger.debug('镜头跟随模式');
        }

        public function debug():void {
            logger.debug('初始化摄影机');
            logger.debug('view rect', rectangle);
        }
        //camera.mirror():Vision

        //public function shooting(scene:IScene):void {
        //    for (var i:int = 0, l:int = scene.layers.length; i < l; i++) {
        //        scene.preShoot(this);
        //        //scene.layers[i].render(this);
        //        scene.addEventListener(TICK, shooting);
        //        scene.addEventListener(Event.COMPLETE, postShoot);
        //        scene.postShoot(this);
        //    }
        //}

        public function shoot(scene:IScene):void {
            scene.action(this);
            ////scene.layers[i].render(this);
            ////scene.addEventListener(Event.COMPLETE, postShoot);
            ////scene.postShoot(this);
        }

        public function record(scene:IScene):void {
            for (var i:int = 0, l:int = scene.layers.length; i < l; i++) {
                add(scene.layers[i]);
            }
            ////scene.layers[i].render(this);
            ////scene.addEventListener(Event.COMPLETE, postShoot);
            ////scene.postShoot(this);
        }

        public function render(scene:IScene):void {
        }

        public function shooting(event:Event):void {
            logger.debug("tick");
        }

        public function add(child:*):* {
            return addChild(child);
        }
    }
}
// SingletonEnforcer
class SingletonEnforcer {}
