package
{
    public interface ISceneLayer {
        function add(child:*):*;
        function render(camera:ICamera):void;
    }
}