package im.luo.game
{
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;

    public interface ISceneLayer {
        function add(child:*):*;
        function addCharacter(character:RoleAbstract):*;

        function preShoot(container:DisplayObjectContainer, rectangle:Rectangle):void;
        function shooting(container:DisplayObjectContainer, rectangle:Rectangle):void;
        function postShoot(container:DisplayObjectContainer, rectangle:Rectangle):void;
    }
}