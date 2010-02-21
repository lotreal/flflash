package im.luo.shooting
{
    import im.luo.camera.ICamera;
    import im.luo.scene.IScene;
    import im.luo.util.Tick;
    import im.luo.events.TickEvent;
    import im.luo.staff.Context;
    
<<<<<<< HEAD:src/im/luo/shooting/ShootingSchedule.as
=======
    /**
    * 拍摄计划，控制场景的拍摄方式，主要指摄像机的移位。
    */
>>>>>>> ba6ebb2d7cc9f0c2f4ed767bf601c9584eefe642:src/im/luo/shooting/ShootingSchedule.as
    public class ShootingSchedule implements IShootingSchedule
    {
        public var scene:*; // IScene
        public var camera:ICamera;
        public var context:Context = Context.instance;
        
        public function ShootingSchedule()
        {
        }
        
<<<<<<< HEAD:src/im/luo/shooting/ShootingSchedule.as
        public virtual function init():void {}
        
=======
        /**
        * 通常在这里初始化场景，摄像机。
        */
        public virtual function init():void {}

        /**
        * 开始拍摄场景
        */
>>>>>>> ba6ebb2d7cc9f0c2f4ed767bf601c9584eefe642:src/im/luo/shooting/ShootingSchedule.as
        public function action():void {
            camera.preShoot(scene);
            Tick.instance.addEventListener(TickEvent.TICK, shooting);
        }
        
<<<<<<< HEAD:src/im/luo/shooting/ShootingSchedule.as
=======
        /**
        * 拍摄场景中
        * @param event TickEvent.
        */
>>>>>>> ba6ebb2d7cc9f0c2f4ed767bf601c9584eefe642:src/im/luo/shooting/ShootingSchedule.as
        public function shooting(event:TickEvent):void {
            scene.play();
            camera.shooting(scene);
        }
<<<<<<< HEAD:src/im/luo/shooting/ShootingSchedule.as
        
=======

        /**
        * 停止拍摄场景
        */
>>>>>>> ba6ebb2d7cc9f0c2f4ed767bf601c9584eefe642:src/im/luo/shooting/ShootingSchedule.as
        public function cut():void {
            Tick.instance.removeEventListener(TickEvent.TICK, shooting);
            camera.postShoot(scene);
        }
    }
}