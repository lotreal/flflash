package im.luo.action
{
    import im.luo.scene.IScene;
    import im.luo.role.IRole;
    import im.luo.util.Keyboard;
    
    public class KeyboardAction implements IRoleAction
    {
        public var scene:*; //IScene;
        public var role:*; //IRole;
        public var keyboard:Keyboard;
        
        public function KeyboardAction(scene:IScene, role:IRole)
        {
            this.role = role;
            this.scene = scene;
            this.keyboard = Keyboard.instance;
        }
        
        public function play():void {}
        
        public function destroy():void {}
        
        public function toString():String {
            return "键盘控制器";
        };
    }
}