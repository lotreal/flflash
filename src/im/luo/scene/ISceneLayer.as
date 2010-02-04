package im.luo.scene
{
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    //import im.luo.role.IRole;

    public interface ISceneLayer {
        function add(child:*):*;
        //function addCharacter(character:IRole):*;

        function get rect():Rectangle;
        function set rect(value:Rectangle):void;

        function preShoot(container:DisplayObjectContainer, rectangle:Rectangle):void;
        function shooting(container:DisplayObjectContainer, rectangle:Rectangle):void;
        function postShoot(container:DisplayObjectContainer, rectangle:Rectangle):void;
    }
}