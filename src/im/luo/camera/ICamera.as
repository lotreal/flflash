package im.luo.camera
{
    import im.luo.role.IRole;
    import im.luo.scene.IScene;

    public interface ICamera {
        // 开始拍摄前的行为
        function preShoot(scene:IScene):void;
        // 执行拍摄动作
        function shooting(scene:IScene):void;
        // 结束拍摄时的行为
        function postShoot(scene:IScene):void;
        // 执行拍摄动作，且拍摄镜头始终跟随某个角色
        function follow(role:IRole):void;
    }
}
