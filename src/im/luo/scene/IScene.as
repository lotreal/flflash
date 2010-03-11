package im.luo.scene
{
    import flash.display.DisplayObjectContainer;
    import flash.events.IEventDispatcher;
    import flash.geom.Rectangle;
    
    import flf.flatland.game.Roles;
    
    import im.luo.role.IRole;
    import im.luo.ui.UI;
    import im.luo.util.Tags;
    
    /**
     * 场景 
     * 场景由层组成，层包含角色
     */    
    public interface IScene extends IEventDispatcher {
        function get state():Tags
        // 所有图层中的角色的引用
        function get roles():Roles
        function set roles(value:Roles):void;

        function get layers():Vector.<ISceneLayer>;
        function set layers(value:Vector.<ISceneLayer>):void;

        function get rect():Rectangle;
        function set rect(value:Rectangle):void;
        
        function get ui():UI;

        function addLayer(layer:ISceneLayer):ISceneLayer;
        function addCharacter(name:String, character:IRole, layer:ISceneLayer):*;

        function build():void;
        function destroy():void;
        function showUI(id:String):void;
        function play():void;

        function preShoot(container:DisplayObjectContainer, rect:Rectangle):void;
        function shooting(container:DisplayObjectContainer, rect:Rectangle):void;
        function postShoot(container:DisplayObjectContainer, rect:Rectangle):void;
    }
}
