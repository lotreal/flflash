package flf.flatland.item
{
    import flf.flatland.game.States;
    import flf.flatland.role.Citizen;
    
    import im.luo.item.ItemAbstract;
    import im.luo.logging.Logger;
    import im.luo.role.IRole;
    
    /**
     * 产生伤害保护的效果，处于伤害保护状态中的人不能攻击他人以及被他人攻击。 
     */    
    public class InjuryProtect extends ItemAbstract
    {
        public function InjuryProtect()
        {
            this.cooldown = 1000;
        }
        
        override public function activate(role:IRole):void
        {
            var citizen:Citizen = role as Citizen;
            citizen.state.add(States.PROTECTED);
            _logger.debug('activate', citizen.name);
        }
        
        override public function deactivate(role:IRole):void
        {
            var citizen:Citizen = role as Citizen;
            citizen.state.remove(States.PROTECTED);
            _logger.debug('deactivate', citizen.name);
        }

        private var _logger:Logger = Logger.getLogger(this);
    }
}