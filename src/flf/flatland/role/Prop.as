package flf.flatland.role
{
    import im.luo.role.RoleAbstract;
    
    public class Prop extends RoleAbstract
    {
        public var color:uint;
        public var radius:int = 10;
        
        public function Prop(name:String, x:int, y:int)
        {
            super(name, x, y);
        }
    }
}