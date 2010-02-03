package flf.flatland.role
{
    import im.luo.logging.Logger;
    
    public class Npc extends Creature {
        private var _logger:Logger = Logger.getLogger(this);
        
        public function Npc(x:int, y:int) {
            super(x, y);
            type = Role.NPC;
            color = 0xffffff;
        }
    }
}
