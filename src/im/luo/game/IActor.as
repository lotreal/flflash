package im.luo.game
{
	import im.luo.geom.Vector2D;

    public interface IActor extends IMoveable {
        function get center():Vector2D;
        function play():void;
        function update():void;
        function destroy():void;
    }
}