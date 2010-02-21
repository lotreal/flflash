package im.luo.action
{
    import im.luo.scene.IScene;
    import im.luo.role.IRole;
    import im.luo.util.Keyboard;
    
    public class KeyboardAction extends RoleAction
    {
        public var keyboard:Keyboard;
        
        public function KeyboardAction(scene:IScene, role:IRole)
        {
            super(scene, role);
            this.keyboard = Keyboard.instance;
        }
        
        override public function toString():String {
            return "键盘控制器";
        };
    }
}