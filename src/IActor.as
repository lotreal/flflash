package
{
	import im.luo.geom.Vector2D;

    public interface IActor extends IMoveable {
        function get center():Vector2D;
        function update():void;
        function destroy():void;
    }
}