package im.luo.shooting
{
    import im.luo.camera.ICamera;
    import im.luo.scene.IScene;
    import im.luo.util.Tick;
    import im.luo.events.TickEvent;
    import im.luo.staff.Context;
    
    public class ShootingSchedule implements IShootingSchedule
    {
        public var scene:*; // IScene
        public var camera:ICamera;
        public var context:Context = Context.instance;
        
        public function ShootingSchedule()
        {
        }
        
        public virtual function init():void {}
        
        public function action():void {
            camera.preShoot(scene);
            Tick.instance.addEventListener(TickEvent.TICK, shooting);
        }
        
        public function shooting(event:TickEvent):void {
            scene.play();
            camera.shooting(scene);
        }
        
        public function cut():void {
            Tick.instance.removeEventListener(TickEvent.TICK, shooting);
            camera.postShoot(scene);
        }
    }
}