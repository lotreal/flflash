package flf.flatland.role
{
    import flf.flatland.actor.PropActor;
    import flf.flatland.face.HeartFace;
    
    import im.luo.role.Role;
    
    public class Heart extends Prop
    {
        public function Heart(name:String, x:int, y:int)
        {
            super(name, x, y);
            type = Roles.HEART;
            this.color = 0xCD1821;
            this.actor = new PropActor(this);
            this.face = new HeartFace(this);

        }
    }
}