package im.luo.actor
{
	import im.luo.geom.Vector2D;
	import im.luo.sim.IMoveable;

    public interface IActor extends IMoveable {
        function play():void;
        function update():void;
        function destroy():void;
    }
}