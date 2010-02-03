package im.luo.scene
{
    import flash.geom.Rectangle;
    import im.luo.camera.ICamera;

    public interface IScene {
        function get layers():Vector.<ISceneLayer>;
        function addLayer(layer:ISceneLayer):ISceneLayer;

        function build():void;
        function play():void;

        function get rect():Rectangle;
        function set rect(value:Rectangle):void;

        function preShoot(camera:ICamera):void;
    }
}
