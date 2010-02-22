package flf.flatland.fight
{
    import im.luo.geom.Vector2D;

    // 保存一场战斗开始时的环境信息，比如攻击点的屏幕坐标。
    public class Manifold
    {
        public function Manifold()
        {
        }
        
        private var _attackPoint:Vector2D = null;
        public function get attackPoint():Vector2D {
            return _attackPoint;
        }
        public function set attackPoint(value:Vector2D):void {
            _attackPoint = value;
        }

    }
}