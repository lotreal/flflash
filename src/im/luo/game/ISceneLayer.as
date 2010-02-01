package im.luo.game
{
    public interface ISceneLayer {
        function add(child:*):*;
        function addCharacter(character:Role):*;
        function render(camera:ICamera):void;
    }
}