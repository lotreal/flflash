package im.luo.scene
{
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    
    import im.luo.role.IRole;

    //import im.luo.role.IRole;

    public interface ISceneLayer {
        // 读写本图层中的所有角色
        function get roles():Vector.<IRole>;
        function set roles(value:Vector.<IRole>):void;
        
        function add(child:*):*;
        //function addCharacter(character:IRole):*;

        function get rect():Rectangle;
        function set rect(value:Rectangle):void;
        
        function destroy():void;
        
        function preShoot(container:DisplayObjectContainer, rectangle:Rectangle):void;
        function shooting(container:DisplayObjectContainer, rectangle:Rectangle):void;
        function postShoot(container:DisplayObjectContainer, rectangle:Rectangle):void;
    }
}