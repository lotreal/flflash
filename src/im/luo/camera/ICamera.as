package im.luo.camera
{
    import im.luo.role.IRole;
    import im.luo.scene.IScene;

    public interface ICamera {
        function add(child:*):*;

        function follow(role:IRole):void;

        function preShoot(scene:IScene):void;
        function shooting(scene:IScene):void;
        function postShoot(scene:IScene):void;
    }
}
