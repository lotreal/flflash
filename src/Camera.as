package 
{
    import flash.display.*;
    import flash.events.*;
    import im.luo.log.Logger;
    import Box2D.Common.Math.*;    
    public class Camera extends MovieClip {
        private static const FOLLOW:String = "follow";

        private static var _instance:Camera = null;
        public static function get instance():Camera {
            return Camera.getInstance();
        }
        public static function getInstance():Camera {
            if (_instance == null) _instance = new Camera(new SingletonEnforcer());
            return _instance;
        }

        private var logger:Logger = Logger.getLogger(this);
        private var context:Context = Context.instance;
        private var current:Sprite = this as Sprite;

        private var shootMode:String = "";
        private var followTarget:Actor;

        public function Camera(singleton_enforcer:SingletonEnforcer):void {
            context.sprite.addChild(this);
            logger.debug('初始化摄影机');
            debug();
            addEventListener(Event.ENTER_FRAME, shoot);
        }

        public function newSprite():Sprite {
            var sprite:Sprite = new Sprite();
            addChild(sprite);
            current = sprite;
            return sprite;
        }

        public function get w():int {
            return context.stage.stageWidth;
        }
        public function get h():int {
            return context.stage.stageHeight;
        }

        public function get g():Graphics {
            return current.graphics;
        }
        public function rx(x:Number):Number {
            if (shootMode == Camera.FOLLOW) {
                var c:b2Vec2 = followTarget.body.GetWorldCenter();
                return x - c.x;
            } else {
                return x*2;
            }
        }
        public function ry(y:Number):Number {
            if (shootMode == Camera.FOLLOW) {
                var c:b2Vec2 = followTarget.body.GetWorldCenter();
                return y - c.y;
            } else {
                return y*2;
            }
        }
        public function beginFill(color:uint, alpha:Number = 1.0):void  {
            g.beginFill(color, alpha);
        }
        public function moveTo(x:Number, y:Number):void {
            x = rx(x); y = ry(y); g.moveTo(x, y);
        }
        public function lineTo(x:Number, y:Number):void {
            x = rx(x); y = ry(y); g.lineTo(x, y);
        }

        public function shoot(e:Event):void {
        }

        public function follow(actor:Actor):void {
            shootMode = Camera.FOLLOW;
            followTarget = actor;
            logger.debug('camera follow actor');
        }

        public function debug():void {
            logger.debug('width',w,'height',h);
        }
    }
}
// SingletonEnforcer
class SingletonEnforcer {}
