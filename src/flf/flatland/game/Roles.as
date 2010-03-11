package flf.flatland.game
{
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    
    import flf.flatland.action.PlayerHotkeyB;
    import flf.flatland.role.Player;
    
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import im.luo.role.IRole;
    import im.luo.scene.IScene;
    import im.luo.scene.ISceneLayer;
    import im.luo.staff.Context;
    import im.luo.util.TimerUtil;
    
    // 演员表，列举角色类型
    public class Roles
    {
        public function Roles() {}
        
        public function layoutRole(scene:IScene, layer:ISceneLayer, role:IRole, position:Vector2D):IRole {
            roles.push(role);
            role.position = position;
            role.scene = scene;
            role.sceneLayer = layer;
            scene.addCharacter("", role, layer);
            //layer.roles.push(role);
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
        
        public function registerPlayer():Player
        {
            _logger.debug('当前用户名', context.user.id);
            var player:Player = new Player(context.user.id);
            player.action = new PlayerHotkeyB(null, player);
            return player;
        }
        
        public function removeRole(remove:IRole):void
        {
            roles = roles.filter(function(role:IRole, index:int, vector:Vector.<IRole>):Boolean
            {
                return (role.uuid != remove.uuid);                
            });
            TimerUtil.delay(100, function handler():void{ remove.destroy(); });
        }
        
        public function destroy(roles:Vector.<IRole>):void
        {
            for (var i:int = 0, n:int = roles.length; i < n; i++) {
                roles[i].destroy();
            }
        }
        
        public function play(roles:Vector.<IRole>):void
        {
            for (var i:int = 0, n:int = roles.length; i < n; i++) {
                roles[i].play();
            }
        }
        
        public function preShoot(roles:Vector.<IRole>, container:DisplayObjectContainer, rect:Rectangle):void
        {
            for (var i:int = 0, n:int = roles.length; i < n; i++) {
                roles[i].preShoot(container, rect);
            }
        }
        
        public function shooting(roles:Vector.<IRole>, container:DisplayObjectContainer, rect:Rectangle):void
        {
            for (var i:int = 0, n:int = roles.length; i < n; i++) {
                roles[i].shooting(container, rect);
            }
        }
        
        public function postShoot(roles:Vector.<IRole>, container:DisplayObjectContainer, rect:Rectangle):void
        {
            for (var i:int = 0, n:int = roles.length; i < n; i++) {
                roles[i].postShoot(container, rect);
            }
        }
        
        public function byLayer(layer:ISceneLayer):Vector.<IRole>
        {
            return roles.filter(function(role:IRole, index:int, vector:Vector.<IRole>):Boolean
            {
                return (role.sceneLayer == layer);                
            });
        }
        
        public function byGroup(group:String):Vector.<IRole>
        {
            return roles.filter(function(role:IRole, index:int, vector:Vector.<IRole>):Boolean
            {
                return (role.groups.has(group));                
            });
        }
        
        public function get all():Vector.<IRole>
        {
            return roles;
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
        
        private var roles:Vector.<IRole> = new Vector.<IRole>();
    }
}