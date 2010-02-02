package flf.flatland.role
{
    import im.luo.logging.Logger;
    
    public class Npc extends Creature {
        private var _logger:Logger = Logger.getLogger(this);
        
        public function Npc(x:Number, y:Number) {
            super(x, y);
            type = "npc_gladiator";
            color = 0xffffff;
        }
    }
}
