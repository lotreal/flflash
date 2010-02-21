package flf.flatland.role
{
    import im.luo.logging.Logger;
    import im.luo.util.MathUtil;
    
    public class Npc extends Creature {
        private var _logger:Logger = Logger.getLogger(this);
        
        public function Npc(name:String, x:int, y:int) {
            var level:int = MathUtil.randomIn(3, 6);
            super(name, x, y, level);
            type = Role.CREATURE;
            color = 0xffffff;
        }
    }
}
