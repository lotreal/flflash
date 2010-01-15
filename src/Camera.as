package 
{
    import flash.display.*;
    import flash.geom.*;
    import flash.events.*;
    import im.luo.logging.Logger;
    import Box2D.Common.Math.*;    

    import flash.utils.getTimer;
    import caurina.transitions.Tweener;
    public class Camera extends Sprite {
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
        private var current:Sprite = this as Sprite;

        private var shootMode:String = Camera.FIXED;
        private var followTarget:Role;

        public var scale:Number = 30;

        public function Camera(singleton_enforcer:SingletonEnforcer):void {
            context.root.addChild(this);
            logger.debug('初始化摄影机');
            //debug();
            addEventListener(Event.ENTER_FRAME, shoot);
        }

        public function newSprite():Sprite {
            var sprite:Sprite = new Sprite();
            addChild(sprite);
            current = sprite;
            return sprite;
        }

        public function get w():int {
            return context.width;
        }
        public function get h():int {
            return context.height;
        }
        public function get g():Graphics {
            return current.graphics;
        }

        public function rx(x:Number):Number {
            return x * scale;
            if (shootMode == Camera.FOLLOW) {
                var c:b2Vec2 = followTarget.body.GetWorldCenter();
                return x - c.x;
            } else {
                return x*2;
            }
        }

        public function ry(y:Number):Number {
            return y * scale;
            if (shootMode == Camera.FOLLOW) {
                var c:b2Vec2 = followTarget.body.GetWorldCenter();
                return y - c.y;
            } else {
                return y*2;
            }
        }

        private var actors:Vector.<Actor> = new Vector.<Actor>;
        public function observe(p_display:*):Vision {
            var vision:Vision = new Vision(this);
            //actors.push(p_display);
            return addChild(vision) as Vision;
        }

        public function shoot(e:Event):void {
            //var a:Actor;
            //for each (a in actors) { a.run(e); a.update(e); }
            if (shootMode == Camera.FOLLOW) {
                var c:b2Vec2 = followTarget.actor.center;
                rotation=0; // If not, matrix starts wrong.
                var m:Matrix=transform.matrix;
                m.tx= (w/2 - c.x * 30);
                m.ty= (h/2 - c.y * 30);
                transform.matrix=m;
            }

        }

        public function follow(role:Role):void {
            shootMode = Camera.FOLLOW;
            followTarget = role;
            logger.debug('镜头跟随模式');
        }

        public function debug():void {
            logger.debug('width',w,'height',h);
        }
        //camera.mirror():Vision
    }
}
// SingletonEnforcer
class SingletonEnforcer {}
