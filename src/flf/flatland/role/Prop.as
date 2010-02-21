package flf.flatland.role
{
    import im.luo.role.RoleAbstract;
    
    public class Prop extends RoleAbstract
    {
        public var color:uint;
        
        public function Prop(name:String, x:int, y:int)
        {
            super(name, x, y);
            radius = 10;
        }
    }
}