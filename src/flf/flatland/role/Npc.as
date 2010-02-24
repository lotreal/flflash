package flf.flatland.role
{
    import im.luo.logging.Logger;
    import im.luo.util.MathUtil;
    import flf.flatland.game.Roles;
    import flf.flatland.game.Groups;

    public class Npc extends Citizen {
        private var _logger:Logger = Logger.getLogger(this);
        
        public function Npc(name:String) {
            var level:int = MathUtil.randomIn(3, 6);
            super(name, level);
            type = Roles.CITIZEN;
            color = 0xffffff;
            groupid = Groups.NPC;
        }
    }
}
