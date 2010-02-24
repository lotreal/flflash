package im.luo.shooting
{
    import im.luo.camera.ICamera;
    import im.luo.scene.IScene;
    import im.luo.util.Tick;
    import im.luo.events.TickEvent;
    import im.luo.staff.Context;
    
    /**
    * 拍摄计划，控制场景的拍摄方式，主要指摄像机的移位。
    */
    public class ShootingSchedule implements IShootingSchedule
    {
        public var scene:*; // IScene
        public var camera:ICamera;
        public var context:Context = Context.instance;
        
        public function ShootingSchedule()
        {
        }
        
        /**
        * 通常在这里初始化场景，摄像机。
        */
        public virtual function init():void {}
        public virtual function destroy():void {
            scene.destroy();
        }
        
        /**
        * 开始拍摄场景
        */
        public function action():void {
            camera.preShoot(scene);
            Tick.instance.addEventListener(TickEvent.TICK, shooting);
        }
        
        /**
        * 拍摄场景中
        * @param event TickEvent.
        */
        public function shooting(event:TickEvent):void {
            scene.play();
            camera.shooting(scene);
        }

        /**
        * 停止拍摄场景
        */
        public function cut():void {
            Tick.instance.removeEventListener(TickEvent.TICK, shooting);
            camera.postShoot(scene);
        }
    }
}