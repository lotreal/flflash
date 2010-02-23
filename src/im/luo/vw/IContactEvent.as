package im.luo.vw
{
    import im.luo.geom.Vector2D;

    public interface IContactEvent
    {
        function getContactPoint():Vector2D;
        function get manifold():Manifold;
        function set manifold(value:Manifold):void;
    }
}