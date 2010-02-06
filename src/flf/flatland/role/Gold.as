package flf.flatland.role
{
    import flf.flatland.face.GoldFace;
    
    import im.luo.role.RoleAbstract;
    import flf.flatland.actor.PropActor;
    import flf.flatland.face.GoldFace;
    
    public class Gold extends Prop
    {
        public function Gold(name:String, x:int, y:int)
        {
            super(name, x, y);
            this.type = Role.GOLD;
            this.color = 0xFFD700;
            this.actor = new PropActor(this);
            this.face = new GoldFace(this);
        }
    }
}