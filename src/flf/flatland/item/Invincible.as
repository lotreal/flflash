package flf.flatland.item
{
    import im.luo.item.ICanUseItem;
    import im.luo.item.ItemAbstract;
    import im.luo.role.IRole;
    import im.luo.logging.Logger;

    import flf.flatland.role.Citizen;
    
    public class Invincible extends ItemAbstract
    {
        public function Invincible()
        {
            this.cooldown = 1000;
        }
        
        override public function activate(role:IRole):void
        {
            var creature:Citizen = role as Citizen;
            creature.invincible = true;
            _logger.debug('activate', creature.name);
        }
        
        override public function deactivate(role:IRole):void
        {
            var creature:Citizen = role as Citizen;
            creature.invincible = false;
            _logger.debug('deactivate', creature.name);
        }

        private var _logger:Logger = Logger.getLogger(this);
    }
}