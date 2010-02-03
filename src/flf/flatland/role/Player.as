package flf.flatland.role
{

	public class Player extends Creature
	{
		public function Player(x:int, y:int)
		{
			super(x, y);
            type = Role.PLAYER;
		}
	}
}