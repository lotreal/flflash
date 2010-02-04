package im.luo.staff 
{
    import flash.events.*;
    import flf.flatland.role.Creature;
    import im.luo.logging.Logger;
    import im.luo.util.Tick;
    import im.luo.events.TickEvent;
    import im.luo.util.Keyboard;
    import im.luo.util.KeyCode;
    import flf.flatland.scene.PlayScene;
    import im.luo.camera.ICamera;
    import im.luo.scene.IScene;
    import im.luo.camera.ICamera;
    import im.luo.scene.IScene;
    
    public class DirectorAbstract extends EventDispatcher {
        public var camera:ICamera;
        public var scene:IScene;
        public var context:Context = Context.instance;

        public function action():void {
            camera.preShoot(scene);
            Tick.instance.addEventListener(TickEvent.TICK, shooting);
        }
        
        public function cut():void {
            Tick.instance.removeEventListener(TickEvent.TICK, shooting);
            camera.postShoot(scene);
        }
        
        public function shooting(event:TickEvent):void {
            scene.play();
            camera.shooting(scene);
        }

        private var _logger:Logger = Logger.getLogger(this);
    }
}