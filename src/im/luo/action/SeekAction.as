package im.luo.action
{
    import flf.flatland.role.Creature;
    import flf.flatland.scene.PlayScene;
    
    public class SeekAction extends RoleAction
    {
        public function SeekAction(scene:PlayScene, role:Creature)
        {
            super(scene, role);
        }
        
        override public function play():void
        {
            //role.actor.seek(scene.player1.position);
            //role.actor.flock(scene.npc_actors);
            role.actor.wander();
        }
        
        override public function toString():String
        {
            return "I seek u";
        }
    }
}