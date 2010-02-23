package flf.flatland.game
{
    import flash.display.Scene;
    
    import im.luo.role.IRole;
    import im.luo.scene.ISceneLayer;

    // 演员表，列举角色类型
    public class Roles
    {
        public static var NULL:String = "null";
        public static var EDGE:String = "edge";
        public static var CITIZEN:String = "creature";
        public static var PLAYER:String = "player";
        public static var NPC:String = "npc";
        public static var HEART:String = "heart";
        public static var GOLD:String = "gold";
        public function Roles()
        {
        }
        
        public function layoutRole(scene:Scene, layer:ISceneLayer, role:IRole):IRole {
            role.face.paint();
            layer.add(role.face);
            return role;
        }
        
        /**
         * 
         * @param scene
         * @param layer
         * @param role
         * @param refreshMode int 刷新方式,可取值有 RefreshMode.ONTIME, RefreshMode.ONDIE
         * @return 
         * 
         */        
        public function generateRole(scene:Scene, layer:ISceneLayer, role:IRole, refreshMode:int):void {}
    }
}