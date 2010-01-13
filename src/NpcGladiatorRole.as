package
{
    import flash.events.*;
    import im.luo.logging.Logger;
    
    public class NpcGladiatorRole extends GladiatorRole {
        private var _logger:Logger = Logger.getLogger(this);
        
        public function NpcGladiatorRole(x:Number, y:Number) {
            super(x, y);
            color = 0xffffff;
        }
    }
}
