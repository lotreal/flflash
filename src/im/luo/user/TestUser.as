package im.luo.user
{
    public class TestUser extends UserAbstract implements IUser
    {
        public function TestUser()
        {
            super();
        }
        
        override public function load():void
        {
            this.id = 'Test_User';
        }
        
        public function save():void
        {
        }
    }
}