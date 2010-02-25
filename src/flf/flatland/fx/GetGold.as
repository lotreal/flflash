package flf.flatland.fx
{
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.text.TextField;
    
    import im.luo.geom.Vector2D;
    import im.luo.staff.Context;
    import im.luo.ui.ITextPanel;
    
    public class GetGold implements ITextPanel
    {
        public var context:Context = Context.instance;
        public var effect:MovieClip;
        public var txt:TextField;
        
        public function GetGold()
        {
            effect = new (context.getLoadedClass("Money"))();
            effect.gotoAndStop(effect.totalFrames);
            effect.x = (context.width - effect.width) /2 - 120;
            effect.y = (context.height - effect.height) /2 - 32;
            context.screen.getUIScreen().addChild(effect);
        }
        
        public function get position():Vector2D
        {
            return new Vector2D(effect.x, effect.y);
        }
        
        public function set position(value:Vector2D):void
        {
            effect.x = value.x;
            effect.y = value.y;
        }
        
        public function get content():String
        {
            return txt.text;
        }
        
        public function set content(value:String):void
        {
            effect.gotoAndPlay(1);
            txt = effect.getChildByName("GoldCount") as TextField;
            txt.text = value;
        }
        
        public function render(c:DisplayObjectContainer):void
        {
        }
        
        public function destroy():void
        {
        }
    }
}