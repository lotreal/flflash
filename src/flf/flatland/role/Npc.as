package flf.flatland.role
{
    import im.luo.logging.Logger;
    
    public class Npc extends Creature {
        private var _logger:Logger = Logger.getLogger(this);
        
        public function Npc(name:String, x:int, y:int) {
            super(name, x, y);
            type = Role.CREATURE;
            color = 0xffffff;
        }
    }
}
