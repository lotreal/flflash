package im.luo.action
{
    import flf.flatland.game.Roles;
    import flf.flatland.role.Citizen;
    import flf.flatland.role.Player;
    import flf.flatland.scene.PlayScene;
    import im.luo.role.IRole;
    
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
                    role.actor.seek(player.position);
                }
                else
                {
                    role.actor.wander();
                }
            }
            else
            {
                role.actor.wander();
                //AdvancedMotion.wander(role);
            }
            //role.actor.seek(scene.player1.position);
            //role.actor.flock(scene.npc_actors);
        }
        
        override public function toString():String
        {
            return "I seek u";
        }
    }
}