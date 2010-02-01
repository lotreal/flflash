package
{
    import im.luo.game.ICamera;

    public interface IShootable {
        function preShoot(camera:ICamera):void;
        function shooting(camera:ICamera):void;
        function postShoot(camera:ICamera):void;
    }
}
