package im.luo.vw
{
    import flash.events.Event;
    
    import im.luo.role.IRole;
    
    public class RoleEvent extends Event
    {
        public var role:IRole;
        
        public function RoleEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
        }
    }
}