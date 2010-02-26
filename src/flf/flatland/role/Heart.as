package flf.flatland.role
{
    import flf.flatland.actor.PropActor;
    import flf.flatland.face.HeartFace;
    import flf.flatland.game.Groups;
    
    import im.luo.role.Role;
    import flf.flatland.game.Roles;
    
    public class Heart extends Prop
    {
        public function Heart(name:String = "")
        {
            super(name);
            this.groups.add(Roles.HEART);
            this.color = 0xCD1821;
            this.actor = new PropActor(this);
            this.face = new HeartFace(this);
        }
    }
}