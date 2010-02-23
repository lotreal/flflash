package im.luo.role
{
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    
    import im.luo.face.Face;
    import im.luo.geom.Vector2D;
    import im.luo.util.Tags;

    public interface IRole {
        function get face():Face;

        function get groupid():int;
        function set groupid(value:int):void;

        function get type():String;
        function set type(value:String):void;

        function get position():Vector2D;
        function set position(value:Vector2D):void;
        
        function get radius():Number;

        // 角色状态
        function get state():Tags;
        function set state(value:Tags):void;
        
        function play():void;

        function preShoot(container:DisplayObjectContainer, rectangle:Rectangle):void;
        function shooting(container:DisplayObjectContainer, rectangle:Rectangle):void;
        function postShoot(container:DisplayObjectContainer, rectangle:Rectangle):void;

    }
}