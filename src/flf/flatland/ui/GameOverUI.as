package flf.flatland.ui
{
    import flash.display.DisplayObject;
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    
    import flf.flatland.scene.PlayScene;
    import flf.flatland.fight.FightProfile;
    
    import im.luo.logging.Logger;
    import im.luo.staff.Context;
    import im.luo.ui.UI;
    
    public class GameOverUI extends EventDispatcher
    {
        public var context:Context = Context.instance;
        public var fightProfile:FightProfile;
        
        private var _logger:Logger = Logger.getLogger(this);
        
        public function GameOverUI()
        {
        }
        
        public function build():void {
            var gameover:MovieClip = new (context.getLoadedClass("GameOver_Window"))();
            gameover.x = (context.width - gameover.width) / 2;
            gameover.y = (context.height - gameover.height) / 2;
            context.screen.getUIScreen().addChild(gameover);

            (gameover.getChildByName("fs_kills") as TextField).text = fightProfile.kills + "";
            (gameover.getChildByName("fs_exp") as TextField).text = fightProfile.exp + "";
            (gameover.getChildByName("fs_golds") as TextField).text = fightProfile.golds + "";
            (gameover.getChildByName("fs_maxcombo") as TextField).text = fightProfile.max_combo + "";
            
            var replay:DisplayObject = gameover.getChildByName("BtnRestart") as DisplayObject;
            replay.addEventListener(MouseEvent.CLICK, onReplay);
            
            var share:DisplayObject = gameover.getChildByName("BtnShare") as DisplayObject;
            share.addEventListener(MouseEvent.CLICK, onShare);

        }
        
        public function onReplay(event:Event):void
        {
            _logger.debug('replay');
            this.dispatchEvent(new Event(PlayScene.REPLAY));
        }
        
        public function onShare(event:Event):void
        {
            _logger.debug('share');
            this.dispatchEvent(new Event(PlayScene.SHARE));
        }
    }
}