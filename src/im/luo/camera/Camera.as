package im.luo.camera 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import im.luo.staff.Context;
    import im.luo.role.IRole;
    import im.luo.scene.IScene;
    
    public class Camera implements ICamera {
        public function Camera(scene:IScene):void {
            this.scene = scene;
            _rect = new Rectangle(0, 0, context.width, context.height);
            debug();
        }
        
        public function preShoot(scene:IScene):void {
            screen = new Sprite();
            context.screen.addScreen(screen);
            
            scene.preShoot(screen, this.rect);
        }
        
        public function shooting(scene:IScene):void {
            scene.shooting(screen, this.rect);
        }
        
        public function postShoot(scene:IScene):void {
            scene.postShoot(screen, this.rect);
        }

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
        }
        
        public function get rect():Rectangle {
            return _rect;
        }
        
        public function set rect(value:Rectangle):void {
            _rect = value;
        }
        
        public function debug():void {
            _logger.debug('初始化摄影机');
            _logger.debug('view rect', rect);
        }
        
        public static const FIXED:String = "fixed";
        public static const FOLLOW:String = "follow";
        
        public var context:Context = Context.instance;
        public var shootMode:String = Camera.FIXED;
        public var followTarget:IRole;
        public var scale:Number = 30;
        public var scene:IScene;
        
        protected var screen:Sprite;
        
        private var _rect:Rectangle = null;
        private var _logger:Logger = Logger.getLogger(this);
    }
}