package flf.flatland.role
{
    
    public class Player extends Creature
    {
        public function Player(name:String, x:int, y:int, level:int)
        {
            super(name, x, y, level);
            type = Role.CREATURE;
        }
    }
}