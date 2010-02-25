package flf.flatland.role
{
    import flf.flatland.actor.PropActor;
    import flf.flatland.face.GoldFace;
    import flf.flatland.game.Groups;
    import flf.flatland.game.Roles;
    
    public class Gold extends Prop
    {
        public var gold:int = 0;
        
        public function Gold(gold:int = 10)
        {
            super("");
            this.type = Roles.GOLD;
            this.color = 0xFFD700;
            this.actor = new PropActor(this);
            this.face = new GoldFace(this);
            this.gold = gold;
            groupid = Groups.GOLD;
        }
    }
}