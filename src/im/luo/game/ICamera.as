package im.luo.game
{

    public interface ICamera {
        function add(child:*):*;
        function preShoot(scene:IScene):void;
        function shooting(scene:IScene):void;
        function postShoot(scene:IScene):void;
    }
}
