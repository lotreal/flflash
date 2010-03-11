package im.luo.user
{
    public class User
    {
        public static var user:IUser = null;
        public static function getUser():IUser
        {
            if (user==null) {
                user = new WebUser();
                if (!user.id) user = new TestUser();
            }
            return user;
        }
    }
}