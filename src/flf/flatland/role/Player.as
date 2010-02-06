package flf.flatland.role
{

    public class Player extends Creature
    {
	public function Player(name:String, x:int, y:int)
	{
	    super(name, x, y);
            type = Role.CREATURE;
	}
    }
}