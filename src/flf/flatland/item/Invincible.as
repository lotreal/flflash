package flf.flatland.item
{
    import im.luo.item.ICanUseItem;
    import im.luo.item.ItemAbstract;
    import im.luo.role.IRole;
    import im.luo.logging.Logger;

    import flf.flatland.role.Creature;
    
    public class Invincible extends ItemAbstract
    {
        public function Invincible()
        {
            this.cooldown = 1000;
        }
        
        override public function activate(role:IRole):void
        {
            var creature:Creature = role as Creature;
            creature.invincible = true;
            _logger.debug('activate', creature.name);
        }
        
        override public function deactivate(role:IRole):void
        {
            var creature:Creature = role as Creature;
            creature.invincible = false;
            _logger.debug('deactivate', creature.name);
        }

        private var _logger:Logger = Logger.getLogger(this);
    }
}