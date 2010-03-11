package im.luo.action
{
    import im.luo.scene.IScene;
    import im.luo.role.IRole;
    
    /**
     * 用来控制角色的行为，动作
     */ 
    public class RoleAction implements IRoleAction
    {
        public var scene:IScene;
        public var role:*;
        
        public function RoleAction(scene:IScene, role:IRole)
        {
            this.role = role;
            this.scene = scene;
        }
        
        public function destroy():void
        {
        }
        
        public function play():void
        {
        }
        
        public function toString():String
        {
            return null;
        }
    }
}