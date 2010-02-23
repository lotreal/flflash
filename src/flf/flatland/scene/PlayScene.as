package flf.flatland.scene
{
    import flash.display.Bitmap;
    import flash.events.TimerEvent;
    import flash.geom.Rectangle;
    
    import flf.flatland.action.PlayerHotkeyB;
    import flf.flatland.fight.Fight;
    import flf.flatland.item.InjuryProtect;
    import flf.flatland.role.Citizen;
    import flf.flatland.role.Edge;
    import flf.flatland.role.Gold;
    import flf.flatland.role.Heart;
    import flf.flatland.role.Npc;
    import flf.flatland.role.Player;
    import flf.flatland.role.Roles;
    import flf.flatland.ui.GameOverUI;
    import flf.flatland.ui.PlaySceneUI;
    
    import im.luo.action.SeekAction;
    import im.luo.actor.IActor;
    import im.luo.geom.Vector2D;
    import im.luo.logging.Logger;
    import im.luo.role.IRole;
    import im.luo.scene.ISceneLayer;
    import im.luo.scene.Scene;
    import im.luo.scene.SpriteLayer;
    import im.luo.scene.TileLayer;
    import im.luo.util.TimerUtil;
    import im.luo.vw.IContactEvent;
    import im.luo.vw.IWorld;
    import im.luo.vw.World;
    
    // 战斗场景
    public class PlayScene extends Scene {
        public var player1:Player;
        public var npcs:Vector.<Npc>;
        public var npc_actors:Vector.<IActor> = new Vector.<IActor>();
        private var fight:Fight = new Fight();
        
        public function PlayScene(rect:Rectangle = null) {
            super(rect);
            npcs = new Vector.<Npc>();
        }
        
        public function beginContact(event:IContactEvent):void {
            _logger.debug('begin contact', event.getContactPoint());
            var a:IRole = event.manifold.role1;
            var b:IRole = event.manifold.role2;

            if (a.groupid == b.groupid) return;
            if (a.type == Roles.EDGE || b.type == Roles.EDGE) return;

            var p:Vector2D = event.getContactPoint();
            if (a.type == Roles.CITIZEN && b.type == Roles.CITIZEN) {
                //collidByCreature(a as Citizen, b as Citizen, p);
                event.manifold.attackPoint = p;
                event.manifold.scene = this;
                fight.attackRolls(event.manifold);
            } else if (a.type == Roles.CITIZEN && b.type == Roles.GOLD) {
                collidByGold(a as Citizen, b as Gold, p);
            } else if (b.type == Roles.CITIZEN && a.type == Roles.GOLD) {
                collidByGold(b as Citizen, a as Gold, p);
            } else if (a.type == Roles.CITIZEN && b.type == Roles.HEART) {
                collidByHeart(a as Citizen, b as Heart, p);
            } else if (b.type == Roles.CITIZEN && a.type == Roles.HEART) {
                collidByHeart(b as Citizen, a as Heart, p);
            }

        }
        
        public function collidByCreature(a:Citizen, b:Citizen, position:Vector2D):void {
            if (a.invincible || b.invincible) {
                _logger.debug('invincible');
                return void;
            }
            var distance1:Number = a.radius - a.position.dist(position);
            var distance2:Number = b.radius - b.position.dist(position);
            _logger.debug('collidByCreature', position, distance1, distance2);
            if (distance1 < distance2) {
                //a.attack(b);
            } else if (distance1 > distance2) {
                //b.attack(a);
            } else {
                _logger.debug('unknown');
            }

            new InjuryProtect().apply(a);
            new InjuryProtect().apply(b);

        }

        public function collidByGold(a:Citizen, b:Gold, position:Vector2D):void {
            a.setGold(a.gold + 100);
            TimerUtil.delay(100, function handler():void{ b.destroy(); });
        }

        public function collidByHeart(a:Citizen, b:Heart, position:Vector2D):void {
            a.hp += 1;
            TimerUtil.delay(100, function handler():void{ b.destroy(); });
        }

        override public function build():void {
            var world:IWorld = World.instance;
            world.addEventListener(World.BEGINCONTACT, beginContact);
            PlaySceneUI.instance.build();

            var bgLayer:ISceneLayer = new TileLayer();

            var bg:Bitmap = context.loader.getBitmap("bg");
            bgLayer.add(bg);

            var mainLayer:ISceneLayer = new SpriteLayer();

            player1 = new Player('user', rect.width / 2, rect.height / 2, 3);
            player1.action = new PlayerHotkeyB(this, player1);
            addCharacter('player', player1, mainLayer);

            var edge:Edge = new Edge('edge', 0, 0);
            addCharacter('edge', edge, mainLayer);

            var npc:Npc;
            var x:Number, y:Number;

            var npcCount:int = 9;
            var goldCount:int = 9;
            var heartCount:int = 9;

            for (var i:int = 0; i < npcCount; i++) {
                x = Math.random() * rect.width;
                y = Math.random() * rect.height;

                npc = new Npc('npc'+i, x, y);
                npc.action = new SeekAction(this, npc);
                addCharacter('npc'+i, npc, mainLayer);
                npcs.push(npc);
                npc_actors.push(npc.actor);
            }

            for (var j:int = 0; j < goldCount; j++) {
                x = Math.random() * rect.width;
                y = Math.random() * rect.height;
                
                var gold:Gold = new Gold('gold'+j, x, y);
                addCharacter('gold'+j, gold, mainLayer);
            }
            
            for (var k:int = 0; k < heartCount; k++) {
                x = Math.random() * rect.width;
                y = Math.random() * rect.height;
                
                var heart:Heart = new Heart('heart'+k, x, y);
                addCharacter('heart'+k, heart, mainLayer);
            }

            var debugLayer:ISceneLayer = new SpriteLayer();
            debugLayer.add(context.cache['world_debug_draw']);

            var uiLayer:ISceneLayer = new SpriteLayer();
            uiLayer.add(context.cache['ui']);

            addLayer(bgLayer);
            addLayer(mainLayer);
            addLayer(debugLayer);
            addLayer(uiLayer);

            _logger.debug("完成游戏场景搭建");
            
            timerUtil = new TimerUtil(120 * 1000, 1000, true);
            timerUtil.addEventListener(TimerEvent.TIMER, timerHandler);
            timerUtil.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
            timerUtil.start();
            
            var gameover_ui:GameOverUI = new GameOverUI();
            gameover_ui.build();
        }

        private function timerHandler(event:TimerEvent):void
        {
            ui.time.content = timerUtil.getTimeString();
        }
        
        private function completeHandler(event:TimerEvent):void {
            _logger.debug(timerUtil.getTimeString());
        }
        
        override public function play():void {
            for (var i:int = 0, l:int = roles.length; i < l; i++) {
                roles[i].play();
            }
        }
        
        public var ui:PlaySceneUI = PlaySceneUI.instance;
        private var timerUtil:TimerUtil;
        private var _logger:Logger = Logger.getLogger(this);
    }
}
