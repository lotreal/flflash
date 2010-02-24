package flf.flatland.game
{
    import flf.flatland.action.PlayerHotkeyB;
    import flf.flatland.role.Player;
    
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import im.luo.role.IRole;
    import im.luo.scene.IScene;
    import im.luo.scene.ISceneLayer;
    import im.luo.staff.Context;
    
    // 演员表，列举角色类型
    public class Roles
    {
        public function Roles()
        {
        }
        
        public static function layoutRole(scene:IScene, layer:ISceneLayer, role:IRole, position:Vector2D):IRole {
            _logger.debug(position);
            role.position = position;
            role.scene = scene;
            scene.addCharacter("", role, layer);
            //role.face.paint();
            //layer.add(role.face);
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
        public function generateRole(scene:IScene, layer:ISceneLayer, role:IRole, refreshMode:int):void {}
        
        public static function registerPlayer():Player
        {
            var player:Player = new Player('user');
            player.action = new PlayerHotkeyB(null, player);
            return player;
        }
        
        public static var context:Context = Context.instance;
        
        public static var NULL:String = "null";
        public static var EDGE:String = "edge";
        public static var CITIZEN:String = "creature";
        public static var NPC:String = "npc";
        public static var HEART:String = "heart";
        public static var GOLD:String = "gold";
        
        public static var PLAYER:String = "player";
        
        private static var _logger:Logger = Logger.getLogger(new Roles());
    }
}