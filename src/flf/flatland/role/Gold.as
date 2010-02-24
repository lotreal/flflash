package flf.flatland.role
{
    import flf.flatland.face.GoldFace;
    
    import im.luo.role.Role;
    import flf.flatland.actor.PropActor;
    import flf.flatland.face.GoldFace;
    import flf.flatland.game.Roles;
    import flf.flatland.game.Groups;
    
    public class Gold extends Prop
    {
        public function Gold(name:String)
        {
            super(name);
            this.type = Roles.GOLD;
            this.color = 0xFFD700;
            this.actor = new PropActor(this);
            this.face = new GoldFace(this);
            groupid = Groups.GOLD;
        }
    }
}