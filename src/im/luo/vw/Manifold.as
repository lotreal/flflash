package im.luo.vw
{
    import flf.flatland.scene.PlayScene;
    
    import im.luo.geom.Vector2D;
    import im.luo.role.IRole;

    // 保存一场战斗开始时的环境信息，比如攻击点的屏幕坐标。
    public class Manifold
    {
        public function Manifold()
        {
        }
        
        public var role1:IRole;
        public var role2:IRole;
        public var attackPoint:Vector2D;
        public var scene:PlayScene;
    }
}