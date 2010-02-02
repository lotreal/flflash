package im.luo.game 
{
    import flash.events.*;
    import flf.flatland.role.Creature;
    import im.luo.logging.Logger;
    import im.luo.util.Tick;
    import im.luo.events.TickEvent;
    import im.luo.util.Keyboard;
    import im.luo.util.KeyCode;
    import flf.flatland.scene.PlayScene;
    import im.luo.game.ICamera;
    import im.luo.game.IScene;
    
    public class DirectorAbstract extends EventDispatcher {
        private var logger:Logger = Logger.getLogger(this);

        public var camera:ICamera;
        public var scene:IScene;
        
        public function action():void {
            camera.preShoot(scene);
            Tick.instance.addEventListener(TickEvent.TICK, shooting);
        }
        
        public function cut():void {
            Tick.instance.removeEventListener(TickEvent.TICK, shooting);
            camera.postShoot(scene);
        }
        
        protected function shooting(event:TickEvent):void {
            scene.play();
            camera.shooting(scene);
        }
    }
}