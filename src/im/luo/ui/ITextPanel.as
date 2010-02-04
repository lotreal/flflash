package im.luo.ui
{
    import im.luo.geom.Vector2D;
    import flash.display.DisplayObjectContainer;

    public interface ITextPanel
    {
        function get position():Vector2D;
        function set position(value:Vector2D):void;

        function get content():String;
        function set content(value:String):void;
        
        function render(c:DisplayObjectContainer):void;
    }
}