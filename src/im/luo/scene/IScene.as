package im.luo.scene
{
    import flash.geom.Rectangle;
    import im.luo.camera.ICamera;
    import im.luo.role.IRole;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;

    public interface IScene {
        function get roles():Vector.<IRole>;
        function set roles(value:Vector.<IRole>):void;

        function get layers():Vector.<ISceneLayer>;
        function set layers(value:Vector.<ISceneLayer>):void;

        function get rect():Rectangle;
        function set rect(value:Rectangle):void;

        function addLayer(layer:ISceneLayer):ISceneLayer;
        function addCharacter(name:String, character:IRole, layer:ISceneLayer):*;

        function build():void;
        function play():void;

        function preShoot(container:DisplayObjectContainer, rect:Rectangle):void;
        function shooting(container:DisplayObjectContainer, rect:Rectangle):void;
        function postShoot(container:DisplayObjectContainer, rect:Rectangle):void;
    }
}
