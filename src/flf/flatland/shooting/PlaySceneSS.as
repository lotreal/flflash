package flf.flatland.shooting
{
    import im.luo.camera.Camera;
    import im.luo.logging.Logger;
    import flf.flatland.scene.PlayScene;
    import im.luo.shooting.ShootingSchedule;
    import im.luo.events.TickEvent;
    import flash.geom.Rectangle;
    import im.luo.staff.Context;
    import im.luo.util.Keyboard;
    import flash.events.KeyboardEvent;
    import im.luo.util.KeyCode;
    import flf.flatland.action.PlayerHotkeyA;
    import flf.flatland.action.PlayerHotkeyB;
    
    public class PlaySceneSS extends ShootingSchedule
    {
        private var _logger:Logger = Logger.getLogger(this);
        private var pcf:int = 0;
        
        public function PlaySceneSS()
        {
<<<<<<< HEAD:src/flf/flatland/shooting/PlaySceneSS.as

        }
        
        override public function init():void {
            var scene:PlayScene = new PlayScene(new Rectangle(0, 0, context.width * 2, context.height * 2));
            scene.build();
            
            var camera:Camera = new Camera(scene);
            
            this.scene = scene;
            this.camera = camera;
        }
        
        override public function action() : void {
=======
        }
        
        override public function init():void
        {
            this.scene = new PlayScene(new Rectangle(0, 0, context.width * 2, context.height * 2));
            this.scene.build();
            this.camera = new Camera(this.scene);
        }
        
        override public function action():void
        {
>>>>>>> ba6ebb2d7cc9f0c2f4ed767bf601c9584eefe642:src/flf/flatland/shooting/PlaySceneSS.as
            super.action();
            context.stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
        }
        
<<<<<<< HEAD:src/flf/flatland/shooting/PlaySceneSS.as
        override public function shooting(event:TickEvent):void {
            scene.play();
            camera.follow(scene.player);
        }
        
        public function handleKeyUp(event:KeyboardEvent):void {
            var c:int  = event.keyCode;
            if(c == KeyCode.N) {
                scene.player.levelUp();
            }
            
            if(c == KeyCode.M) {
                scene.player.levelDown();
=======
        override public function shooting(event:TickEvent):void
        {
            scene.play();
            camera.follow(scene.player1);
        }
        
        /**
         * 场景快捷键：N=升级，M=降级，空格=切换操作方案。
         */
        public function handleKeyUp(event:KeyboardEvent):void {
            var c:int  = event.keyCode;
            if(c == KeyCode.N) {
                scene.player1.levelUp();
            }
            
            if(c == KeyCode.M) {
                scene.player1.levelDown();
>>>>>>> ba6ebb2d7cc9f0c2f4ed767bf601c9584eefe642:src/flf/flatland/shooting/PlaySceneSS.as
            }
            
            if(c == KeyCode.SPACEBAR) {
                pcf++;
                pcf = pcf > 1 ? 0 : pcf;
<<<<<<< HEAD:src/flf/flatland/shooting/PlaySceneSS.as
                if (pcf == 1) scene.player.action = new PlayerHotkeyB(scene, scene.player);
                else scene.player.action = new PlayerHotkeyA(scene, scene.player);
=======
                if (pcf == 1) scene.player1.action = new PlayerHotkeyB(scene, scene.player1);
                else scene.player1.action = new PlayerHotkeyA(scene, scene.player1);
>>>>>>> ba6ebb2d7cc9f0c2f4ed767bf601c9584eefe642:src/flf/flatland/shooting/PlaySceneSS.as
            }
            
            if(c == KeyCode.D) {
            }
        }
    }
}