package im.luo.game
{
    import flash.events.IEventDispatcher;

    public interface IScene extends IEventDispatcher {
        function get layers():Vector.<ISceneLayer>;
        function addLayer(layer:ISceneLayer):ISceneLayer;
        function build():void;

        function preShoot(camera:ICamera):void;
        function action(camera:ICamera):void;
        function render(camera:ICamera):void;

        function play():void;
    }
}
