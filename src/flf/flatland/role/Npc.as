package flf.flatland.role
{
    import im.luo.logging.Logger;
    import im.luo.util.MathUtil;
    import flf.flatland.game.Roles;
    
    public class Npc extends Citizen {
        private var _logger:Logger = Logger.getLogger(this);
        
        public function Npc(name:String, x:int, y:int) {
            var level:int = MathUtil.randomIn(3, 6);
            super(name, x, y, level);
            type = Roles.CITIZEN;
            color = 0xffffff;
        }
    }
}
