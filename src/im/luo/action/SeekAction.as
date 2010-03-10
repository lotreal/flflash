package im.luo.action
{
    import flf.flatland.game.Roles;
    import flf.flatland.role.Citizen;
    import flf.flatland.role.Player;
    import flf.flatland.scene.PlayScene;
    import im.luo.role.IRole;
    import im.luo.motion.AdvancedMotion;
    
    public class SeekAction extends RoleAction
    {
        public function SeekAction(scene:PlayScene, role:Citizen)
        {
            super(scene, role);
        }
        
        override public function play():void
        {
            var players:Vector.<IRole> = scene.roles.byGroup(Roles.PLAYER);
            if (players.length > 0)
            {
                var player:IRole = players[0];
                if (role.position.dist(player.position) < 160)
                {
                    AdvancedMotion.seek(role, player.position);
                }
                else
                {
                    AdvancedMotion.wander(role);
                }
            }
            else
            {
                AdvancedMotion.wander(role);
            }
        }
        
        override public function toString():String
        {
            return "I seek u";
        }
    }
}