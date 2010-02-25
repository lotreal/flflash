package flf.flatland.ui
{
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    
    import flf.flatland.scene.PlayScene;
    
    import im.luo.logging.Logger;
    import im.luo.staff.Context;
    import im.luo.ui.UI;
    
    public class GameOverUI extends EventDispatcher
    {
        public var context:Context = Context.instance;
        public var fight_profile:String;
        
        private var _logger:Logger = Logger.getLogger(this);
        
        public function GameOverUI()
        {
        }
        
        public function build():void {
            var gameover:MovieClip = new (context.getLoadedClass("GameOver"))();
            gameover.x = (context.width - gameover.width) / 2;
            gameover.y = (context.height - gameover.height) / 2;
            context.screen.getUIScreen().addChild(gameover);
            
            var txt:TextField = gameover.getChildByName("TxtProfile") as TextField;
            txt.text = fight_profile;    
            
            var replay:MovieClip = gameover.getChildByName("BtnReplay") as MovieClip;
            replay.addEventListener(MouseEvent.CLICK, onReplay);
        }
        
        public function onReplay(event:Event):void
        {
            _logger.debug('replay');
            this.dispatchEvent(new Event(PlayScene.REPLAY));
        }
    }
}