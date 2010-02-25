package flf.flatland.ui
{    
    import flash.display.DisplayObjectContainer;
    import flash.display.Shape;
    
    import flf.flatland.fx.Combo;
    import flf.flatland.fx.GetGold;
    
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import im.luo.staff.Context;
    import im.luo.staff.Screen;
    import im.luo.ui.ITextPanel;
    import im.luo.ui.UI;
    
    public class PlaySceneUI extends UI
    {
        public var combo:Combo;
        public var gold:GetGold;
        public var score:ITextPanel;
        public var time:ITextPanel;

        private var _logger:Logger = Logger.getLogger(this);

        public function PlaySceneUI() { super(); }

        override public function build():void {
            var child:Shape = new Shape();
            child.graphics.beginFill(0xffffff);
            child.graphics.lineStyle(1, 0xffffff);
            child.graphics.drawRect(0, 0, context.width, 19);
            child.graphics.endFill();
            child.alpha = 0.5;
            
            var screen_ui:DisplayObjectContainer = context.screen.addScreenByName(Screen.SCREEN_UI, true);
            //UI.fixScreen.addChild(child);
            screen_ui.addChild(child);;

            combo = new Combo();
            combo.position = new Vector2D(context.width - 166, 32);
            gold = new GetGold();

            score = fixTextPanel(new Vector2D(9, 0), context.width, 18, 12, 0x0066cc);
            score.content = "Score : 0";
            
            time = fixTextPanel(new Vector2D(700, 0), 72, 18, 12, 0x008964);
            time.content = "time";
            
            register('combo', combo);
            register('gold', gold);
            register('score', score);
            register('time', time);
        }
    }
}