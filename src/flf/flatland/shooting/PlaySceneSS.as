package flf.flatland.shooting
{
    import flash.events.Event;
    import flash.geom.Rectangle;
    
    import flf.flatland.scene.PlayScene;
    
    import im.luo.camera.Camera;
    import im.luo.events.TickEvent;
    import im.luo.logging.Logger;
    import im.luo.shooting.ShootingSchedule;
    import im.luo.staff.Context;
    
    public class PlaySceneSS extends ShootingSchedule
    {
        private var _logger:Logger = Logger.getLogger(this);
        private var pcf:int = 0;
        
        public function PlaySceneSS()
        {
        }
        
        public var $scene:PlayScene;
        override public function init():void
        {
            $scene = new PlayScene(new Rectangle(0, 0, context.width * 2, context.height * 2));
            this.scene = $scene;
            this.scene.build();
            this.camera = new Camera(this.scene);
            this.scene.addEventListener(PlayScene.REPLAY, replay);
        }
        
        public function replay(event:Event):void
        {
            Context.director.remake(this);
        }
        
        override public function action():void
        {
            super.action();
            //context.stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
        }
        
        override public function shooting(event:TickEvent):void
        {
            scene.play();
            camera.follow($scene.player1);
        }
        
        /**
         * 场景快捷键：N=升级，M=降级，空格=切换操作方案。

        public function handleKeyUp(event:KeyboardEvent):void {
            var c:int  = event.keyCode;
            if(c == KeyCode.N) {
                scene.player1.levelUp();
            }
            
            if(c == KeyCode.M) {
                scene.player1.levelDown();
            }
            
            if(c == KeyCode.SPACEBAR) {
                pcf++;
                pcf = pcf > 1 ? 0 : pcf;
                if (pcf == 1) scene.player1.action = new PlayerHotkeyB(scene, scene.player1);
                else scene.player1.action = new PlayerHotkeyA(scene, scene.player1);
            }
            
            if(c == KeyCode.D) {
            }
        }         */
    }
}