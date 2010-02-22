package flf.flatland.role
{
    import im.luo.role.Role;
    
    public class Prop extends Role
    {
        public var color:uint;
        
        public function Prop(name:String, x:int, y:int)
        {
            super(name, x, y);
            radius = 10;
        }
    }
}