package flf.flatland.role
{
    import flf.flatland.face.GoldFace;
    
    import im.luo.role.Role;
    import flf.flatland.actor.PropActor;
    import flf.flatland.face.GoldFace;
    import flf.flatland.game.Roles;
    
    public class Gold extends Prop
    {
        public function Gold(name:String, x:int, y:int)
        {
            super(name, x, y);
            this.type = Roles.GOLD;
            this.color = 0xFFD700;
            this.actor = new PropActor(this);
            this.face = new GoldFace(this);
        }
    }
}