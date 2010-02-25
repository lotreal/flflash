package im.luo.vw
{
    import im.luo.vw.box2d.Box2DWorld;

    public class World
    {
        [Event(name="RemoveRole",type="im.luo.vw.RoleEvent")]
        public static var REMOVEROLE:String = "RemoveRole";
        // Contact based events
        [Event(name="BeginContact",type="im.luo.vw.box2d.ContactEvent")]
        public static var BEGINCONTACT:String = "BeginContact";
        
        public function World() {}
        
        public static function get instance():IWorld {
            return Box2DWorld.instance;
        }
    }
}