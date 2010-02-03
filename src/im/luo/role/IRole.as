package im.luo.role
{
    import im.luo.geom.Vector2D;

    public interface IRole {
        function play():void;

        function get position():Vector2D;
        function set position(value:Vector2D):void;
    }
}