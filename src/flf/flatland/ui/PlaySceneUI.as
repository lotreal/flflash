package flf.flatland.ui
{    
    import flash.display.Shape;
    
    import flf.flatland.fx.Combo;
    import flf.flatland.fx.GetGold;

    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import im.luo.staff.Context;
    import im.luo.ui.ITextPanel;
    import im.luo.ui.UI;
    
    public class PlaySceneUI
    {
        public var context:Context = Context.instance;
        public var combo:Combo;
        public var gold:GetGold;
        public var score:ITextPanel;
        public var time:ITextPanel;

        private static var _instance:PlaySceneUI = null;
        private var _logger:Logger = Logger.getLogger(this);

        public function PlaySceneUI(singleton_enforcer:SingletonEnforcer) {}

        public static function get instance():PlaySceneUI {
            return PlaySceneUI.getInstance();
        }

        public static function getInstance():PlaySceneUI {
            if (_instance == null) _instance = new PlaySceneUI(new SingletonEnforcer());
            return _instance;
        }

        public function build():void {
            UI.instance;

            var child:Shape = new Shape();
            child.graphics.beginFill(0xffffff);
            child.graphics.lineStyle(1, 0xffffff);
            child.graphics.drawRect(0, 0, context.width, 19);
            child.graphics.endFill();
            child.alpha = 0.5;
            UI.fixScreen.addChild(child);

            combo = new Combo();
            combo.position = new Vector2D(context.width - 166, 32);
            gold = new GetGold();

            score = UI.fixTextPanel(new Vector2D(9, 0), context.width, 18, 12, 0x0066cc);
            score.content = "Score : 0";
            time = UI.fixTextPanel(new Vector2D(700, 0), 72, 18, 12, 0x008964);
            time.content = "time";
        }
    }
}
// SingletonEnforcer
class SingletonEnforcer {}