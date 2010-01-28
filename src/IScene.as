package
{
    public interface IScene {
        function get layers():Vector.<ISceneLayer>;
        function addLayer(layer:ISceneLayer):ISceneLayer;
        function build():void;
    }
}
