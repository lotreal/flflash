package im.luo.camera 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import flf.flatland.game.Context;
    import im.luo.role.IRole;
    import im.luo.scene.IScene;
    
    public class Camera implements ICamera {
        //private static var _instance:Camera = null;
        //public static function get instance():Camera {
        //    return Camera.getInstance();
        //}
        //public static function getInstance():Camera {
        //    if (_instance == null) _instance = new Camera(new SingletonEnforcer());
        //    return _instance;
        //}

        public static const FIXED:String = "fixed";
        public static const FOLLOW:String = "follow";

        private var logger:Logger = Logger.getLogger(this);
        private var context:Context = Context.instance;

        private var shootMode:String = Camera.FIXED;
        private var followTarget:IRole;

        protected var screen:Sprite;

        public var scale:Number = 30;
        private var scene:IScene;

        public function Camera(scene:IScene):void {
            this.scene = scene;
            _rect = new Rectangle(0, 0, context.width, context.height);
            logger.debug(rect);
            debug();
        }

        private var _rect:Rectangle = null;
        public function get rect():Rectangle {
            return _rect;
        }
        public function set rect(value:Rectangle):void {
            _rect = value;
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

        public function follow(role:IRole):void {
            shootMode = Camera.FOLLOW;
            var p:Vector2D = role.position;
            rect.x = p.x - rect.width/2;
            rect.y = p.y - rect.height/2;

            if (rect.x < 0 ) rect.x = 0;
            if (rect.y < 0 ) rect.y = 0;
            if (rect.x + rect.width > scene.rect.width ) rect.x = scene.rect.width - rect.width;
            if (rect.y + rect.height > scene.rect.height ) rect.y = scene.rect.height - rect.height;

            shooting(scene);
            //var m:Matrix=screen.transform.matrix;
            //m.tx= rect.width/2 - center.x;
            //m.ty= rect.height/2 - center.y;
            //screen.transform.matrix=m;
            //logger.debug(m);
        }

        public function debug():void {
            logger.debug('初始化摄影机');
            logger.debug('view rect', rect);
        }

        public function preShoot(scene:IScene):void {
            screen = new Sprite();
            context.root.addChild(screen);

            for (var i:int = 0, l:int = scene.layers.length; i < l; i++) {
                scene.layers[i].preShoot(screen, this.rect);
            }
        }

        public function shooting(scene:IScene):void {
            for (var i:int = 0, l:int = scene.layers.length; i < l; i++) {
                scene.layers[i].shooting(screen, this.rect);
            }
        }

        public function postShoot(scene:IScene):void {
            for (var i:int = 0, l:int = scene.layers.length; i < l; i++) {
                scene.layers[i].postShoot(screen, this.rect);
            }
        }

        public function add(child:*):* {
            return screen.addChild(child);
        }
    }
}