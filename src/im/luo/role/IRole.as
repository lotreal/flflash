package im.luo.role
{
    import im.luo.geom.Vector2D;
    import im.luo.face.Face;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;

    public interface IRole {
        function get face():Face;

        function get position():Vector2D;
        function set position(value:Vector2D):void;

        function play():void;

        function preShoot(container:DisplayObjectContainer, rectangle:Rectangle):void;
        function shooting(container:DisplayObjectContainer, rectangle:Rectangle):void;
        function postShoot(container:DisplayObjectContainer, rectangle:Rectangle):void;

    }
}