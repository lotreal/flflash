package im.luo.game
{

    public interface ICamera {
        function add(child:*):*;
        function shoot(scene:IScene):void;
        function record(scene:IScene):void;
    }
}
